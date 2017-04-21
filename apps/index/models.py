# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from django.contrib.auth.models import User
from django.db import models
from datetime import datetime


# Create your models here.
class Categoria(models.Model):

    class Meta:
        verbose_name = 'Categoria'
        verbose_name_plural = 'Categorias'

    nombre = models.CharField(max_length=50, verbose_name="Nombre")

    def __unicode__(self):
        nombre = u'%s' % self.nombre
        return nombre


class Productos(models.Model):

    class Meta:
        verbose_name = 'Producto'
        verbose_name_plural = 'Productos'

    nombre = models.CharField(max_length=150, verbose_name="Nombre")
    categoria = models.ForeignKey(Categoria, verbose_name="Categoria")
    bloqueado = models.BooleanField(default=False, verbose_name="Bloqueado")
    costo = models.DecimalField(default=0.00, max_digits=8, decimal_places=2, verbose_name="Costo")
    descripcion = models.CharField(default="N/A", max_length=250, verbose_name="Descripción", blank=True, null=True)
    exento = models.BooleanField(default=False)

    def __unicode__(self):
        nombre = u'%s' % self.nombre
        return nombre

    def formated_id(self):
        formated_id = u'%05d' % self.pk
        return formated_id


class Tamanoproducto(models.Model):

    class Meta:
        verbose_name = 'Tamaño Producto'
        verbose_name_plural = 'Tamaños Productos'

    producto = models.ForeignKey(Productos)
    tamano = models.CharField(max_length=150, verbose_name="Nombre")
    posicion = models.IntegerField(default=1)
    precio_unitario = models.DecimalField(max_digits=8, decimal_places=2, verbose_name="Precio Unitario")
    default = models.BooleanField(default=True)

    def __unicode__(self):
        nombre = u'%s' % self.tamano
        return nombre


class Modificadores(models.Model):

    class Meta:
        verbose_name = 'Modificador'
        verbose_name_plural = 'Modificadores'

    nombre = models.CharField(max_length=50, verbose_name="Nombre")
    descripcion = models.CharField(max_length=250, verbose_name="Descripción")
    productos_asociados = models.ManyToManyField(Productos, verbose_name="Productos Asociados")
    precio = models.DecimalField(max_digits=8, decimal_places=2, verbose_name="Precio")

    def __unicode__(self):
        nombre = u'%s' % self.nombre
        return nombre


class Combos(models.Model):

    class Meta:
        verbose_name = 'Combo'
        verbose_name_plural = 'Combos'

    nombre = models.CharField(max_length=150, verbose_name="Nombre")
    productos = models.ManyToManyField(Productos, verbose_name="Producto")
    bloqueado = models.BooleanField(default=False, verbose_name="Bloqueado")
    costo = models.DecimalField(max_digits=8, decimal_places=2, verbose_name="Costo", null=True, blank=True)
    descripcion = models.CharField(default="N/A", max_length=250, verbose_name="Descripción", blank=True, null=True)

    def __unicode__(self):
        nombre = u'%s' % self.nombre
        return nombre

    def formated_id(self):
        formated_id = u'%05d' % self.pk
        return formated_id


class Tamanocombo(models.Model):
    class Meta:
        verbose_name = 'Tamaño Combo'
        verbose_name_plural = 'Tamaños Combos'

    combo = models.ForeignKey(Combos)
    tamano = models.CharField(max_length=150, verbose_name="Nombre")
    posicion = models.IntegerField(default=1)
    precio = models.DecimalField(max_digits=8, decimal_places=2, verbose_name="Precio Unitario")
    default = models.BooleanField(default=False)

    def __unicode__(self):
        nombre = u'%s' % self.tamano
        return nombre


# Tarjetas de debito, credito, efectivo, cesta ticket#
class Formasdepago(models.Model):

    class Meta:
        verbose_name = 'Forma de Pago'
        verbose_name_plural = 'Formas de Pago'

    nombre = models.CharField(max_length=150, verbose_name="Nombre")

    def __unicode__(self):
        return u'%s' % self.nombre


#  #
class Tipodeventa(models.Model):

    class Meta:
        verbose_name = 'Tipo de Venta'
        verbose_name_plural = 'Tipos de Venta'

    nombre = models.CharField(max_length=150, verbose_name="Nombre")
    codigo = models.IntegerField(verbose_name="Código")

    def __unicode__(self):
        nombre = u'%s' % self.nombre
        return nombre


class Establecimientos(models.Model):

    class Meta:
        verbose_name = 'Establecimiento'
        verbose_name_plural = 'Establecimientos'

    razonsocial = models.CharField(max_length=150, verbose_name="Razón Social")
    rif = models.CharField(max_length=150, verbose_name="Rif")
    activo = models.BooleanField(default=False)

    def __unicode__(self):
        nombre = u'%s' % self.razonsocial
        return nombre


class Ventas(models.Model):

    class Meta:
        verbose_name = 'Venta'
        verbose_name_plural = 'Ventas'

    total_neto = models.DecimalField(default=0.00, max_digits=8, decimal_places=2, verbose_name="Total Neto", blank=True, null=True)
    iva = models.DecimalField(default=0.00, max_digits=8, decimal_places=2, verbose_name="Iva", blank=True, null=True)
    fecha = models.DateTimeField(auto_now_add=True, verbose_name="Fecha", blank=True, null=True)
    total_bruto = models.DecimalField(default=0.00, max_digits=8, decimal_places=2, verbose_name="Total Bruto", blank=True, null=True)
    vendedor = models.ForeignKey(User, verbose_name="Vendedor")
    caja = models.IntegerField(verbose_name="Caja")
    tipo_venta = models.ForeignKey(Tipodeventa, verbose_name="Tipo de Venta", blank=True, null=True)
    tiempo_venta = models.DateTimeField(verbose_name="Duración de la Venta", blank=True, null=True)
    establecimiento = models.ForeignKey(Establecimientos, default=1, verbose_name="Establecimiento")

    def __unicode__(self):
        nombre = u'%d' % self.id
        return nombre


class Pagos(models.Model):
    class Meta:
        verbose_name = 'Pago'
        verbose_name_plural = 'Pagos'

    forma = models.ForeignKey(Formasdepago, verbose_name="Forma de Pago", blank=True, null=True)
    monto = models.DecimalField(default=0.00, max_digits=8, decimal_places=2, verbose_name="Monto")
    venta = models.ForeignKey(Ventas, verbose_name="Venta Asociada")


class Pedidos(models.Model):

    class Meta:
        verbose_name = 'Pedido'
        verbose_name_plural = 'Pedidos'

    producto = models.ForeignKey(Productos, verbose_name="Producto", blank=True, null=True)
    combo = models.ForeignKey(Combos, verbose_name="Combo", blank=True, null=True)
    tamano = models.CharField(default="Regular", max_length=100, verbose_name="Tamaño del Producto/Combo")
    modificador = models.ManyToManyField(Modificadores, verbose_name="Modificador", blank=True)
    venta = models.ForeignKey(Ventas, verbose_name="Venta")

    def __unicode__(self):
        nombre = u'%d' % int(self.id)
        return nombre


class Clientes(models.Model):

    class Meta:
        verbose_name = 'Cliente'
        verbose_name_plural = 'Clientes'

    nombre = models.CharField(default="Sin", max_length=150, verbose_name="Nombre")
    apellido = models.CharField(default="Cliente", max_length=150, verbose_name="Apellido")
    documento = models.CharField(default="V12345678", max_length=150, verbose_name="Nro. Documento", unique=True)
    direccion = models.TextField(verbose_name="Direccion")

    def __unicode__(self):
        nombre = u'%s %s' % (self.nombre, self.apellido)
        return nombre


class Facturas(models.Model):

    class Meta:
        verbose_name = 'My Factura'
        verbose_name_plural = 'Facturas'

    venta = models.ForeignKey(Ventas, verbose_name="Venta")
    preciototal = models.DecimalField(max_digits=8, decimal_places=2, verbose_name="Precio Total")
    preciobruto = models.DecimalField(max_digits=8, decimal_places=2, verbose_name="Precio Bruto")
    iva = models.DecimalField(max_digits=8, decimal_places=2, verbose_name="Iva")
    fecha = models.DateTimeField(auto_now_add=True, verbose_name="Fecha")
    vendedor = models.ForeignKey(User, verbose_name="Vendedor")
    caja = models.IntegerField(verbose_name="Caja", blank=True, null=True)
    cliente = models.ForeignKey(Clientes, verbose_name="Cliente")
    nrofactura = models.IntegerField(verbose_name="Nro Factura", blank=True, null=True)
    precioneto = models.DecimalField(max_digits=8, decimal_places=2, verbose_name="Precio Neto")
    establecimiento = models.ForeignKey(Establecimientos, verbose_name="Establecimiento")
    serialimpresora = models.CharField(default="000000000000", max_length=50, verbose_name="Serial de Impresora")

    def __unicode__(self):
        nombre = u'%d' % self.nrofactura
        return nombre


class Notasdecredito(models.Model):

    class Meta:
        verbose_name = 'Nota de Crédito'
        verbose_name_plural = 'Notas de Crédito'

    venta = models.ForeignKey(Ventas, verbose_name="Venta")
    preciototal = models.DecimalField(max_digits=8, decimal_places=2, verbose_name="Precio Total")
    preciobruto = models.DecimalField(max_digits=8, decimal_places=2, verbose_name="Precio Bruto")
    iva = models.DecimalField(max_digits=8, decimal_places=2, verbose_name="Iva")
    fecha = models.DateTimeField(auto_now_add=True, verbose_name="Fecha")
    vendedor = models.ForeignKey(User, verbose_name="Vendedor")
    caja = models.IntegerField(verbose_name="Caja", blank=True, null=True)
    cliente = models.ForeignKey(Clientes, verbose_name="Cliente")
    factura = models.ForeignKey(Facturas, verbose_name="Factura")
    precioneto = models.DecimalField(max_digits=8, decimal_places=2, verbose_name="Precio Neto")
    establecimiento = models.ForeignKey(Establecimientos, verbose_name="Establecimiento")
    nronotacred = models.IntegerField(verbose_name="Nro Nota de Crédito", blank=True, null=True)
    serialimpresora = models.CharField(default="000000000000", max_length=50, verbose_name="Serial de Impresora")

    def __unicode__(self):
        nombre = u'%d' % self.factura.id
        return nombre


class Borradas(models.Model):

    class Meta:
        verbose_name = 'Borrada'
        verbose_name_plural = 'Borradas'

    combo = models.ForeignKey(Combos, verbose_name="Combo", blank=True, null=True)
    producto = models.ForeignKey(Productos, verbose_name="Producto", blank=True, null=True)
    modificador = models.ForeignKey(Modificadores, verbose_name="Modificador", blank=True, null=True)
    venta = models.ForeignKey(Ventas, verbose_name="Venta", blank=True, null=True)
    monto = models.DecimalField(max_digits=8, decimal_places=2, verbose_name="Precio Total")
    vendedor = models.ForeignKey(User, verbose_name="Vendedor")
    establecimiento = models.ForeignKey(Establecimientos, verbose_name="Establecimiento")


class Globals(models.Model):

    class Meta:
        verbose_name = 'Variable Global'
        verbose_name_plural = 'Variables Globales'

    nombre = models.CharField(max_length=150, verbose_name="Nombre")
    valor = models.CharField(max_length=150, verbose_name="Valor")

    def __unicode__(self):
        nombre = u'%s' % self.nombre
        return nombre
