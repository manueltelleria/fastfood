# -*- coding: utf-8 -*-
from django.shortcuts import render
from django.views.generic import TemplateView, FormView, ListView, CreateView, UpdateView, DeleteView, DetailView
from django.db.models import Q
from .models import *
from django.core import serializers
from django.http import HttpResponse
from itertools import chain
import json
import tf_ve_ifpython
import datetime
import serial
import decimal
from decimal import Decimal, ROUND_UP
from django.utils.dateformat import DateFormat
import csv


class Vista(ListView):
    template_name = 'index/index.html'
    model = Categoria
    context_object_name = 'categoria'

    def get_context_data(self, **kwargs):
        context = super(Vista, self).get_context_data(**kwargs)
        context['iva'] = Globals.objects.get(nombre="iva")
        context['iva_electronico'] = Globals.objects.get(nombre="iva_electronico")
        context['producto'] = Productos.objects.all()
        context['combo'] = Combos.objects.all()
        context['metodos_pago'] = Formasdepago.objects.all()
        efectivo = Formasdepago.objects.get(nombre="Efectivo")
        context['efectivo'] = efectivo.id
        electronico = Formasdepago.objects.get(nombre="TDD")
        context['electronico'] = electronico.id
        estable = Establecimientos.objects.get(activo=True)
        context['establecimiento'] = estable
        venta = Ventas()
        user = User.objects.get(id=self.request.user.id)
        venta.vendedor = user
        venta.establecimiento = estable
        venta.caja = 1
        venta.save()
        context['venta'] = venta
        return context


def csv_export(request):

    # Create the HttpResponse object with the appropriate CSV header.
    response = HttpResponse(content_type='text/csv')
    fecha = datetime.datetime.now()
    response['Content-Disposition'] = 'attachment; filename="venda_%s.csv"' % fecha.date()
    ventas = Ventas.objects.all()
    writer = csv.writer(response)
    writer.writerow(['codigo', 'producto', 'cantidad', 'precio', 'usuario'])
    producto = False
    combo = False
    for item in ventas:
        writer.writerow(['venta', item.id])
        pedido_list = Pedidos.objects.filter(venta=item)
        for pedido in pedido_list:
            try:
                producto = pedido.producto
            except Exception as e:
                producto = pedido.combo
            if producto:
                tamanio = Tamanoproducto.objects.get(producto=producto)
                writer.writerow([producto.id, unicode(producto.nombre).encode("utf-8"), 1, tamanio.precio_unitario, unicode("%s %s" % (item.vendedor.first_name, item.vendedor.last_name))])

    return response


class AgregarPedidoAjax(TemplateView):

    def get(self, request, *args, **kwargs):
        id_prod = request.GET['boton']
        prd_lst = id_prod.split('_')

        if prd_lst[0] == "prd":
            querie = Productos.objects.filter(id=prd_lst[1])
            precios = Tamanoproducto.objects.filter(producto=querie, default=True)
            combined = list(chain(querie, precios))
            data = serializers.serialize('json', combined)  # , fields=('nombre', 'precio_unitario')
        else:
            querie_cmb = Combos.objects.filter(id=prd_lst[1])
            querie_prod = querie_cmb[0].productos.all()
            querie = Tamanocombo.objects.filter(combo=querie_cmb, default=True)
            combined = chain(querie_cmb, querie)
            for prod in querie_prod:
                producto = Productos.objects.filter(id=prod.id)
                combined = chain(combined, producto)
                tamano = Tamanoproducto.objects.filter(producto=producto, tamano=querie[0].tamano)
                combined = chain(combined, tamano)
            combined = list(combined)
            data = serializers.serialize('json', combined)  # , fields=('total', 'nombre', 'precio_combo')
        return HttpResponse(data, content_type='application/json')


class AgregarBorradaAjax(TemplateView):

    def get(self, request, *args, **kwargs):
        id_prod = request.GET['cod_producto']
        id_mod = request.GET['cod_modificador']
        id_combo = request.GET['cod_combo']
        id_venta = request.GET['venta']
        id_usuario = request.GET['usuario']
        id_estable = request.GET['establecimiento']
        monto = round(float(request.GET['monto']), 2)
        borrada = Borradas()
        try:
            producto = Productos.objects.get(id=id_prod)
            borrada.producto = producto
        except Productos.DoesNotExist:
            pass
        try:
            combo = Combos.objects.get(id=id_combo)
            borrada.combo = combo
        except Combos.DoesNotExist:
            pass
        try:
            modificador = Modificadores.objects.get(id=id_mod)
            borrada.modificador = modificador
        except Modificadores.DoesNotExist:
            pass
        venta = Ventas.objects.get(id=id_venta)
        usuario = User.objects.get(pk=id_usuario)
        establecimiento = Establecimientos.objects.get(pk=id_estable)
        borrada.vendedor = usuario
        borrada.establecimiento = establecimiento
        borrada.monto = monto
        borrada.venta = venta
        borrada.save()
        data = [{"result": "ok"}]

        return HttpResponse(json.dumps(data), content_type='application/json')


# Funcion añadir modificadores
def ajaxaddmods(request):
    if request.is_ajax():
        codigos_full = request.POST.getlist("codigos[]")
        codigos_split = []
        data = []
        for cod in codigos_full:
            number = cod.split("-")
            if number[0] == "C":
                combo = Combos.objects.get(pk=int(number[1]))
                for prod in combo.productos.all():
                    codigos_split.append(int(prod.pk))
            else:
                codigos_split.append(int(number[1]))
        productos = Productos.objects.filter(pk__in=codigos_split)
        modificadores = Modificadores.objects.filter(productos_asociados__in=productos)
        for mod in list(set(modificadores)):
            data.append({"nombre": mod.nombre, "codigo": mod.pk, "precio": str(mod.precio), "tipo": "M"})
        cat_extra = Categoria.objects.get(nombre="Extras")
        extras = Productos.objects.filter(categoria=cat_extra)
        for prod in extras:
            producto = Productos.objects.filter(id=prod.id)
            tamano = Tamanoproducto.objects.filter(producto=producto, default=True)
            data.append({"nombre": producto[0].nombre, "codigo": producto[0].pk, "precio": str(tamano[0].precio_unitario), "tipo": "E"})
        return HttpResponse(json.dumps(data), content_type='application/json')
    return None


# Funcion cambiar productos/modificadores
def ajaxchprds(request):
    if request.is_ajax():
        codigos_full = request.POST.getlist("codigos[]")
        codigos_split = []
        data = []
        for cod in codigos_full:
            number = cod.split("-")
            codigos_split.append(int(number[1]))
        number = codigos_full[0].split("-")
        if number[0] == "P":
            producto = Productos.objects.get(pk=codigos_split[0])
            querie = Productos.objects.filter(categoria=producto.categoria)
            precios = Tamanoproducto.objects.filter(producto__in=querie, default=True)
            combined = list(chain(querie, precios))
        else:
            producto = Productos.objects.get(pk=codigos_split[0])
            querie = Modificadores.objects.filter(productos_asociados=producto)
            #precios = Tamanoproducto.objects.filter(producto__in=querie, default=True)
            combined = list(querie)
        data = serializers.serialize('json', combined)
        return HttpResponse(data, content_type='application/json')
    return None


# Funcion añadir extras
def ajaxaddextra(request):
    if request.is_ajax():
        codigos_full = request.POST.getlist("codigos[]")
        codigos_split = []
        data = []
        for cod in codigos_full:
            number = cod.split("-")
            if number[0] == "C":
                combo = Combos.objects.get(pk=int(number[1]))
                for prod in combo.productos.all():
                    codigos_split.append(int(prod.pk))
            else:
                codigos_split.append(int(number[1]))
        productos = Productos.objects.filter(pk__in=codigos_split)
        modificadores = Modificadores.objects.filter(productos_asociados__in=productos)
        for mod in list(set(modificadores)):
            data.append({"nombre": mod.nombre, "codigo": mod.pk, "precio": str(mod.precio)})
        return HttpResponse(json.dumps(data), content_type='application/json')
    return None


# Esta funcion genera la linea que se va a imprimir en la factura #
def line(tipo, item, tamanio, combo, form_p):
    iva = ""
    if tipo == 1:
        if form_p != 1:
            linea = '#'
            iva = Globals.objects.get(nombre="iva_electronico")
        elif item.exento:
            linea = " "
        else:
            linea = "!"
            iva = Globals.objects.get(nombre="iva")
    else:
        if form_p != 1:
            linea = '#'
            iva = Globals.objects.get(nombre="iva_electronico")
        else:
            linea = "!"
            iva = Globals.objects.get(nombre="iva")

    incluido = Globals.objects.get(nombre="incluido")
    if tipo == 1:
        if combo == 0:
            if incluido.valor == "incluido":
                precio = tamanio.precio_unitario
            else:
                precio = ((100+decimal.Decimal(iva.valor)) * tamanio.precio_unitario)/100
        else:
            precio = decimal.Decimal(0.00)
        linea += (str(Decimal(precio.quantize(Decimal('.01'), rounding=ROUND_UP))).translate(None, ".,")).zfill(10)
        linea += '1000'.zfill(8)
        linea += item.nombre.upper()
    elif tipo == 2:
        if incluido.valor == "incluido":
            precio = tamanio.precio
        else:
            precio = ((100+decimal.Decimal(iva.valor)) * tamanio.precio)/100
        linea += (str(Decimal(precio.quantize(Decimal('.01'), rounding=ROUND_UP))).translate(None, ".,")).zfill(10)
        linea += '1000'.zfill(8)
        linea += item.nombre.upper()
    # print linea
    return linea


def ajaxventa(request):
    if request.is_ajax():
        data_r = json.loads(request.body)
        items = data_r['items']
        usuario = User.objects.get(pk=data_r['usuario'])
        establecimiento = Establecimientos.objects.get(pk=data_r['establecimiento'])
        caja = Globals.objects.get(nombre="caja")
        ObjIva  = Globals.objects.get(nombre="iva")
        ObjIvaElectronico = Globals.objects.get(nombre="iva_electronico")

        # Cliente #
        cli_docu = data_r['cli_doc']
        cli_nomb = data_r['cli_nom']
        cli_apel = data_r['cli_ape']
        cli_dire = data_r['cli_dir']
        try:
            cliente = Clientes.objects.get(documento=cli_docu)
        except Clientes.DoesNotExist:
            cliente = Clientes()
            cliente.nombre = cli_nomb.upper()
            cliente.apellido = cli_apel.upper()
            cliente.documento = cli_docu.upper()
            cliente.direccion = cli_dire.upper()
            cliente.save()
        pagos = data_r['pagos']
        form_pag = ""
        for pay in pagos:
            formpago = Formasdepago.objects.get(pk=int(pay['forma']))
            if formpago.nombre == "Efectivo":
                form_pag = 1
            else:
                form_pag = 2

        # Venta #
        venta = Ventas.objects.get(pk=data_r['venta'])
        total = data_r['total']
        subtotal = data_r['subtotal']
        if form_pag == 1:
            iva = ObjIva.valor
        else:
            iva = ObjIvaElectronico.valor

        venta.total_bruto = float(subtotal)
        venta.total_neto = float(total)
        venta.iva = float(iva)
        venta.save()

        last_item = ""
        data_s = []
        imprimir = ['i01RAZ/NOM: %s %s' % (cliente.nombre.upper(), cliente.apellido.upper()), 'i02RIF/CED: %s' % cliente.documento.upper()]
        com_prod_num = 0
        for item in items:
            codigo = item['codigo']
            nombre = item['nombre']
            split_nom = nombre.split('-')
            # id_item = item['id_item'] todavia por ver si se necesita
            pedido = Pedidos()
            cod_split = codigo.split('-')
            if cod_split[0] == "C":
                combo = Combos.objects.get(pk=int(cod_split[1]))
                com_prod_num = combo.productos.count()
                tamano = Tamanocombo.objects.get(combo=combo, tamano=split_nom[1])
                pedido.combo = combo
                pedido.venta = venta
                pedido.tamano = split_nom[1]
                pedido.save()
                imprimir.append(line(2, combo, tamano, 0, form_pag))
                last_item = pedido
            elif cod_split[0] == "P":
                producto = Productos.objects.get(pk=int(cod_split[1]))
                tamano = Tamanoproducto.objects.get(producto=producto, tamano=split_nom[1])
                pedido.producto = producto
                pedido.venta = venta
                pedido.tamano = split_nom[1]
                pedido.save()
                imprimir.append(line(1, producto, tamano, com_prod_num, form_pag))
                if com_prod_num != 0:
                    com_prod_num -= 1
                last_item = pedido
            elif cod_split[0] == "M":
                modificador = Modificadores.objects.get(pk=int(cod_split[1]))
                last_item.modificador.add(modificador)
        imprimir.append('101')

        # imprimir #

        imp = tf_ve_ifpython.tf_ve_ifpython()
        port = Globals.objects.get(nombre="puerto")
        try:
            imp.mdepura = True
            imp.OpenFpctrl(port.valor)
            for linea in imprimir:
                if imp.SimpleCmd(linea.encode(encoding='utf-8')):
                    continue
                else:
                    print(imp.envio)
            estado1 = imp.estados1("S1")

            # Pagos #

            pagos = data_r['pagos']
            for pay in pagos:
                pago = Pagos()
                formpago = Formasdepago.objects.get(pk=int(pay['forma']))
                pago.forma = formpago
                pago.monto = float(pay['monto'])
                pago.venta = venta
                pago.save()

            # Factura #

            factura = Facturas()
            factura.venta = venta
            factura.preciobruto = subtotal
            factura.precioneto = total
            factura.preciototal = total
            factura.iva = iva
            factura.vendedor = usuario
            factura.cliente = cliente
            factura.establecimiento = establecimiento
            factura.nrofactura = int(estado1[2])  # aqui debe ir el numero de factura arrojado por la impresora
            factura.caja = caja.valor
            factura.serialimpresora = estado1[9]
            factura.save()

            log = "nrofactura= %d, serialimp= %s" % (factura.nrofactura, factura.serialimpresora)
            data_s.append({"status": "ok", "log": "%s" % log})
        except Exception as e:
            data_s.append({"status": "error", "message": "Error: %s" % e.message})
        return HttpResponse(json.dumps(data_s), content_type='application/json')
    return None


def ajaxgetclient(request):
    if request.is_ajax():
        documento = request.POST.get("documento")
        data = []
        try:
            client = Clientes.objects.get(documento=documento)
            data.append({"status": "ok", "nombre": client.nombre, "apellido": client.apellido, "direccion": client.direccion})
        except Clientes.DoesNotExist:
            data.append({"status": "Not Found"})

        return HttpResponse(json.dumps(data), content_type='application/json')
    return None


# Funcion para Agrandar Producto/Combo
def ajaxaument(request):
    if request.is_ajax():
        codigos_full = json.loads(request.body)
        data = []
        items = codigos_full["items"]
        mode = codigos_full["mode"]
        for cod in items:
            number = cod["codigo"].split("-")
            if number[0] == "C":
                combo = Combos.objects.get(pk=int(number[1]))
                tamanio = Tamanocombo.objects.filter(combo=combo, tamano=cod["tamano"])
                posicion = tamanio[0].posicion
                try:
                    if int(mode) == 1:
                        aument = Tamanocombo.objects.get(combo=combo, posicion=(posicion + 1))
                    else:
                        aument = Tamanocombo.objects.get(combo=combo, posicion=(posicion - 1))
                    data.append({"codigo": cod["codigo"],
                                 "tamano": aument.tamano,
                                 "precio": str(aument.precio),
                                 "error": "0"})
                except Tamanocombo.DoesNotExist:
                    data.append({"codigo": cod["codigo"],
                                 "tamano": tamanio[0].tamano,
                                 "precio": str(tamanio[0].precio),
                                 "error": "1"})
            elif number[0] == "P":
                producto = Productos.objects.get(pk=int(number[1]))
                tamanio = Tamanoproducto.objects.filter(producto=producto, tamano=cod["tamano"])
                posicion = tamanio[0].posicion
                try:
                    if int(mode) == 1:
                        aument = Tamanoproducto.objects.get(producto=producto, posicion=(posicion + 1))
                    else:
                        aument = Tamanoproducto.objects.get(producto=producto, posicion=(posicion - 1))
                    data.append({"codigo": cod["codigo"],
                                 "tamano": aument.tamano,
                                 "exento": producto.exento,
                                 "precio": str(aument.precio_unitario),
                                 "error": "0"})
                except Tamanoproducto.DoesNotExist:
                    data.append({"codigo": cod["codigo"],
                                 "tamano": tamanio[0].tamano,
                                 "exento": producto.exento,
                                 "precio": str(tamanio[0].precio_unitario),
                                 "error": "1"})

        return HttpResponse(json.dumps(data), content_type='application/json')
    return None


# Funcion para buscar datos de factura para generar nota de crédito
def ajaxsearchfact(request):

    data = []
    if request.is_ajax():
        factura = request.POST.get("factura")

        #  Busqueda Factura

        try:
            fact = Facturas.objects.get(nrofactura=factura)
            datefact = DateFormat(fact.fecha)
            nom_cliente = "%s %s" % (fact.cliente.nombre, fact.cliente.apellido)
            documento = fact.cliente.documento
            monto = fact.preciototal
            data.append({
                "status": "ok",
                "nombre": nom_cliente,
                "documento": documento,
                "monto": str(monto),
                "nrofact": fact.nrofactura,
                "fecha": datefact.format('d/m/Y')
            })
        except Facturas.DoesNotExist:
            data.append({"status": "Not Found"})
            return HttpResponse(json.dumps(data), content_type='application/json')

    return HttpResponse(json.dumps(data), content_type='application/json')


# Funcion para reversar factura (Emitir nota de credito)
def ajaxreversefact(request):
    if request.is_ajax():
        usuario = User.objects.get(pk=request.POST.get("usuario"))
        establecimiento = Establecimientos.objects.get(pk=request.POST.get("establecimiento"))
        caja = Globals.objects.get(nombre="caja")
        factura = request.POST.get("factura")
        data = []
        error_log = ""

        #  Busqueda Factura

        try:
            fact = Facturas.objects.get(nrofactura=factura)
            datefact = DateFormat(fact.fecha)
        except Facturas.DoesNotExist:
            data.append({"status": "Not Found"})
            return HttpResponse(json.dumps(data), content_type='application/json')

        try:
            nota_old = Notasdecredito.objects.get(factura=fact)
            data.append({"status": "Already Exist"})
            return HttpResponse(json.dumps(data), content_type='application/json')
        except Notasdecredito.DoesNotExist:
            pass

        pagos = Pagos.objects.get(venta=fact.venta)

        #  Generación de comandos para impresora

        port = Globals.objects.get(nombre="puerto")
        imp = tf_ve_ifpython.tf_ve_ifpython()
        try:
            imp.mdepura = True
            imp.OpenFpctrl(port.valor)
            estado1 = imp.estados1("S1")
            imprimir = ['iR*%s' % fact.cliente.documento.upper(),
                        'iS*%s %s' % (fact.cliente.nombre.upper(), fact.cliente.apellido.upper()),
                        'iF*%s' % fact.nrofactura,
                        'iD*%s' % datefact.format('d-m-Y'),
                        'iI*%s' % estado1[9]]

            pedido = Pedidos.objects.filter(venta=fact.venta)
            incluido = Globals.objects.get(nombre="incluido")
            cont_combo = 0
            for item in pedido:
                error_log += " item: "
                producto = item.producto
                combo = item.combo
                modifi = item.modificador
                if modifi.count() > 0:
                    pri_modi = modifi.precio
                else:
                    pri_modi = 0
                if combo is not None:
                    tamanio = Tamanocombo.objects.get(combo=combo, tamano=item.tamano)
                    if incluido.valor == "incluido":
                        precio = tamanio.precio+pri_modi
                    else:
                        precio = ((100 + decimal.Decimal(fact.iva)) * (tamanio.precio+pri_modi)) / 100
                    precio_end = (str(Decimal(precio.quantize(Decimal('.01'), rounding=ROUND_UP))).translate(None, ".,")).zfill(10)
                    if pagos.forma.nombre == "Efectivo":
                        imprimir.append('d1%s%s%s' % (precio_end, '1000'.zfill(8), combo.nombre.upper()))
                    else:
                        imprimir.append('d3%s%s%s' % (precio_end, '1000'.zfill(8), combo.nombre.upper()))
                    cont_combo = combo.productos.count()
                if producto is not None:
                    if cont_combo == 0:
                        tamanio = Tamanoproducto.objects.get(producto=producto, tamano=item.tamano)
                        if incluido.valor == "incluido":
                            precio = tamanio.precio_unitario + pri_modi
                        else:
                            precio = ((100 + decimal.Decimal(fact.iva)) * (tamanio.precio_unitario + pri_modi)) / 100
                        precio_end = (str(Decimal(precio.quantize(Decimal('.01'), rounding=ROUND_UP))).translate(None, ".,")).zfill(10)
                        if pagos.forma.nombre == "Efectivo":
                            imprimir.append('d1%s%s%s' % (precio_end, '1000'.zfill(8), producto.nombre.upper()))
                        else:
                            imprimir.append('d3%s%s%s' % (precio_end, '1000'.zfill(8), producto.nombre.upper()))
                    else:
                        cont_combo -= 1
                        pass

            imprimir.append('101')

            #  Impresión de Nota de Crédito

            for linea in imprimir:
                if imp.SimpleCmd(linea.encode(encoding='utf-8')):
                    continue
                else:
                    print(imp.envio)

            #  Creación de Nota de Crédito

            estado1 = imp.estados1("S1")
            notadecredito = Notasdecredito()
            notadecredito.venta = fact.venta
            notadecredito.preciototal = fact.preciototal
            notadecredito.precioneto = fact.precioneto
            notadecredito.preciobruto = fact.preciobruto
            notadecredito.iva = fact.iva
            notadecredito.vendedor = usuario
            notadecredito.establecimiento = establecimiento
            notadecredito.caja = caja.valor
            notadecredito.cliente = fact.cliente
            notadecredito.factura = fact
            notadecredito.nronotacred = estado1[6]
            notadecredito.serialimpresora = estado1[9]
            notadecredito.save()

            data.append({"status": "ok"})
        except Exception as e:
            data.append({"status": "Error Print '%s' log: %s " % (e.message, error_log)})
            return HttpResponse(json.dumps(data), content_type='application/json')

        return HttpResponse(json.dumps(data), content_type='application/json')
    return None


# Funcion para generar reporte z
def ajaxreportez(request):
    if request.is_ajax():
        data = []

        #  Generación de comandos para impresora
        port = Globals.objects.get(nombre="puerto")
        imp = tf_ve_ifpython.tf_ve_ifpython()
        try:

            imp.mdepura = True
            imp.OpenFpctrl(port.valor)
            imp.updateReport("I0Z")

            data.append({"status": "ok"})
        except Exception as e:
            data.append({"status": "Error Print: %s" % e})
            return HttpResponse(json.dumps(data), content_type='application/json')

        return HttpResponse(json.dumps(data), content_type='application/json')
    return None


# Funcion para generar reporte x
def ajaxreportex(request):
    if request.is_ajax():
        data = []

        #  Generación de comandos para impresora
        port = Globals.objects.get(nombre="puerto")
        imp = tf_ve_ifpython.tf_ve_ifpython()
        try:
            imp.mdepura = True
            imp.OpenFpctrl(port.valor)
            imp.updateReport("I0X")

            data.append({"status": "ok"})
        except Exception as e:
            data.append({"status": "Error Print: %s" % e})
            return HttpResponse(json.dumps(data), content_type='application/json')

        return HttpResponse(json.dumps(data), content_type='application/json')
    return None
