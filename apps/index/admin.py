from django.contrib import admin
from .models import Productos, Pedidos, Formasdepago, Ventas, Categoria, Modificadores, Combos, Tipodeventa, Clientes, \
    Facturas, Notasdecredito, Borradas, Establecimientos, Globals, Tamanoproducto, Tamanocombo, Pagos
# Register your models here.


class BorradasAdmin(admin.ModelAdmin):
    list_display = ('id', 'combo', 'producto', 'modificador', 'venta', 'monto', 'vendedor', 'establecimiento')


class TamanocomboInline(admin.TabularInline):
    model = Tamanocombo
    extra = 1


class CombosAdmin(admin.ModelAdmin):
    fields = ("nombre", "productos", "bloqueado", "descripcion")
    filter_horizontal = ("productos", )
    inlines = [TamanocomboInline, ]


class ModificadoresAdmin(admin.ModelAdmin):
    filter_horizontal = ("productos_asociados", )


class EstablecimientosAdmin(admin.ModelAdmin):
    list_display = ("id", "razonsocial", "rif", "activo")


class PedidosAdmin(admin.ModelAdmin):
    list_display = ("id", "producto", "combo", "venta")


class TamanoproductoAdmin(admin.ModelAdmin):
    list_display = ("id", "producto", "tamano", "posicion", "precio_unitario")


class TamanoproductoInline(admin.TabularInline):
    model = Tamanoproducto
    extra = 1


class ProductosAdmin(admin.ModelAdmin):
    fields = ("nombre", "categoria", "bloqueado", "exento", "descripcion")
    list_display = ('id', 'nombre', 'categoria', 'bloqueado', 'exento', 'descripcion')
    inlines = [TamanoproductoInline, ]


class TamanocomboAdmin(admin.ModelAdmin):
    list_display = ("id", "combo", "tamano", "posicion", "precio")


class FormasPagoAdmin(admin.ModelAdmin):
    list_display = ("id", "nombre")


class ClientesAdmin(admin.ModelAdmin):
    list_display = ("id", "nombre", "apellido", "documento", "direccion")

class PagosAdmin(admin.ModelAdmin):
    list_display = ("id", "monto", "forma_id", "venta_id")

admin.site.register(Productos, ProductosAdmin)
admin.site.register(Combos, CombosAdmin)
admin.site.register(Categoria)
admin.site.register(Modificadores, ModificadoresAdmin)
admin.site.register(Ventas)
admin.site.register(Formasdepago, FormasPagoAdmin)
admin.site.register(Tipodeventa)
admin.site.register(Pedidos, PedidosAdmin)
admin.site.register(Clientes, ClientesAdmin)
admin.site.register(Facturas)
admin.site.register(Notasdecredito)
admin.site.register(Borradas, BorradasAdmin)
admin.site.register(Establecimientos, EstablecimientosAdmin)
admin.site.register(Globals)
admin.site.register(Tamanoproducto, TamanoproductoAdmin)
admin.site.register(Tamanocombo, TamanocomboAdmin)
admin.site.register(Pagos, PagosAdmin)
