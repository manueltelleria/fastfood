# -*- coding: utf-8 -*-
from django.conf.urls import url, patterns
from .views import *
from django.contrib.auth.decorators import login_required
from django.contrib.auth.views import login, logout_then_login

# 'django.contrib.auth.views.login'
# 'django.contrib.auth.views.logout_then_login'
urlpatterns = [
                # LOGIN/INICIO
                url(r'^$', login, {'template_name': 'index/login.html'}, name='login'),
                # LOGOUT
                url(r'^logout/$', logout_then_login, name='logout'),
                # VENTA
                url(r'^venta/$', csv_export, name='csv_export'),
                # APP
                url(r'^app/$', login_required(Vista.as_view()), name="index_vista"),
                # AJAX AGREGAR PEDIDO
                url(r'^agregar_pedido_ajax/$', AgregarPedidoAjax.as_view()),
                # AJAX REGISTRAR BORRADA
                url(r'^agregar_borrada_ajax/$', AgregarBorradaAjax.as_view()),
                # AJAX MOSTRAR MODIFICADORES DE PRODUCTOS
                url(r'^add_mods_ajax/$', ajaxaddmods),
                # AJAX MOSTRAR PRODUCTOS A CAMBIAR
                url(r'^cha_prds_ajax/$', ajaxchprds),
                # AJAX EJECUTAR VENTA
                url(r'^venta_ajax/$', ajaxventa),
                # AJAX BUSCAR CLIENTE
                url(r'^get_client_ajax/$', ajaxgetclient),
                # AJAX AGRANDAR PRODUCTO/COMBO
                url(r'^aument_ajax/$', ajaxaument),
                # AJAX DEVOLUCION FACTURA
                url(r'^reverse_factura_ajax/$', ajaxreversefact),
                # AJAX BUSCAR FACTURA
                url(r'^search_factura_ajax/$', ajaxsearchfact),
                # AJAX REPORTE Z
                url(r'^reporte_z_ajax/$', ajaxreportez),
                # AJAX REPORTE x
                url(r'^reporte_x_ajax/$', ajaxreportex)

               ]

# urlpatterns += patterns('apps.index.views',
#
#                         )
