$(document).ready(function(){

	showDialog('#metodo_pago');

	String.prototype.capitalize = function() {
		return this.charAt(0).toUpperCase() + this.slice(1);
	};

	String.prototype.replaceAll = function(search, replace){
		if (replace === undefined) {
			return this.toString();
		}
		return this.replace(new RegExp('[' + search + ']', 'g'), replace);
	};

	function getCookie(name) {
		var cookieValue = null;
		if (document.cookie && document.cookie != '') {
			var cookies = document.cookie.split(';');
			for (var i = 0; i < cookies.length; i++) {
				var cookie = jQuery.trim(cookies[i]);
				// Does this cookie string begin with the name we want?
				if (cookie.substring(0, name.length + 1) == (name + '=')) {
					cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
					break;
				}
			}
		}
		return cookieValue;
	}

	var csrftoken = getCookie('csrftoken');

	function csrfSafeMethod(method) {
		// these HTTP methods do not require CSRF protection
		return (/^(GET|HEAD|OPTIONS|TRACE)$/.test(method));
	}
	$.ajaxSetup({
		beforeSend: function(xhr, settings) {
			if (!csrfSafeMethod(settings.type) && !this.crossDomain) {
				xhr.setRequestHeader("X-CSRFToken", csrftoken);
			}
		}
	});

	/* DataTables */
	var table = $('.table-factura').DataTable({
		"scrollY": "50vh",
		"scrollCollapse": true,
		"paging": false,
		"searching": false,
		"info": false,
		"ordering": false,
		"bFilter": false,
		"stripeClasses": [],
		"language": {
			"emptyTable": "No hay productos agregados"
		}
	});

	$('.dataTables_wrapper').css("background-color", "#e8f1f4");

	/* Funcion para rellenar strings con 0 */
	function paddy(n, p, c) {
		var pad_char = typeof c !== 'undefined' ? c : '0';
		var pad = new Array(1 + p).join(pad_char);
		return (pad + n).slice(-pad.length);
	}

	/* Funcion para obtener iva algun producto. monto(float): recibe el monto del cual se quiere obtener iva */
	function get_iva(monto){
		var metodo = $("#metodo_p").val();
		var iva = "";
		if(metodo == "efectivo"){
			iva = parseFloat($("#iva").val());
		}else{
			iva = parseFloat($("#iva_elect").val());
		}
		return (iva * monto) / 100.00;
	}

	/* Funcion para aumentar precio de factura cada vez que se agrega una linea */
	function updatePrice(monto, exento){
		var total = parseFloat($(".fac-total").html());
		var sub_total = parseFloat($(".fac-sub-total").html());
		var iva = parseFloat($(".fac-iva").html());
		var sub_tot = parseFloat(monto) + get_iva(parseFloat(monto));
		var tot = parseFloat(monto);
		var iv = 0.0;
		if(exento == 0){
			iv = get_iva(parseFloat(monto));
		}
		total = total + tot;
		sub_total = sub_total + sub_tot;
		iva = iva + iv;
		$(".fac-total").html(total.toFixed(2));
		$(".fac-sub-total").html(sub_total.toFixed(2));
		$(".fac-iva").html(iva.toFixed(2));
	}

	function updatePriceDown(monto, exento){
		var total = parseFloat($(".fac-total").html());
		var sub_total = parseFloat($(".fac-sub-total").html());
		var iva  = parseFloat($(".fac-iva").html());
		var sub_tot = parseFloat(monto) + get_iva(parseFloat(monto));
		var tot = parseFloat(monto);
		var iv = 0.0;
		if (exento == 0) {
			iv = get_iva(parseFloat(monto));
		}
		total = total - tot;
		sub_total = sub_total - sub_tot;
		iva = iva + iv;
		$(".fac-total").html(total.toFixed(2));
		$(".fac-sub-total").html(sub_total.toFixed(2));
		$(".fac-iva").html(iva.toFixed(2));
	}
	/*$(".combo").click(function () {
	 alert("Funciono");
	 var id_cmb = $(this).attr("id");
	 $("#"+id_cmb+",.combo").addClass("selected");
	 });*/
	function select_element(node) {
		var node_class = $(node).attr('class');
		var node_id = $(node).attr('id');

		$(node).click(function () {
			var id_cmb_2 = "";
			$('.del_modi').prop('disabled', false).addClass('danger');
			if($(this).hasClass("selected")){
				$(this).removeClass('selected');
				id_cmb_2 = $(this).attr('class');
				$('.cha_modi').prop('disabled', false).addClass('primary');
				$.each(table.rows('.'+id_cmb_2).nodes(), function () {
					$(this).removeClass('selected');
				});
			}else{
				$('.cha_modi').prop('disabled', true).removeClass('primary');
				$.each(table.rows('.selected').nodes(), function () {
					$(this).removeClass("selected");
				});
				id_cmb_2 = $(this).attr('class');
				$.each(table.rows('.'+id_cmb_2).nodes(), function () {
					$(this).addClass('selected');
				});
			}
		});
	}
	function select_element_p(node) {

		$(node).click(function () {
			$('.cha_modi').prop('disabled', false).addClass('primary');
			if($(this).hasClass('selected')){
				var num = table.rows('.selected').nodes();
				$.each(table.rows('.selected').nodes(), function () {
					$(this).removeClass("selected");
				});
				if(num.length != 1){
					$(this).addClass("selected");
					$('.del_modi').prop('disabled', true).removeClass('danger');
				}else{
					$('.del_modi').prop('disabled', false).addClass('danger');
				}

			}else{
				$.each(table.rows('.selected').nodes(), function () {
					$(this).removeClass("selected");
				});
				$(this).addClass("selected");
				$('.del_modi').prop('disabled', true).removeClass('danger');
			}
		});
	}
	function select_element_sp(node) {
		$(node).click(function () {
			if($(this).hasClass("selected")){
				$(this).removeClass("selected");
			}else{
				$.each(table.rows('.selected').nodes(), function () {
					$(this).removeClass("selected");
				});
				$(this).addClass("selected");
			}
		});
	}

	$(".cat").click(function(){
		var valor = $(this).attr('id');
		var cant_items = $("#cant_items").val();

		var item = $(this);
		$.ajax({
			data: { 'boton': valor },
			url: '/agregar_pedido_ajax/',
			type: 'get',
			success: function(data) {
				var pk_filled = "";
				var new_node_cmb = "";
				if(data[0].model == "index.productos"){
					cant_items++;
					pk_filled = paddy(data[0].pk, 5);
					new_node = table.row.add(["P-"+pk_filled, data[0].fields.nombre+"-"+data[1].fields.tamano, data[1].fields.precio_unitario]).draw().node();
					$(new_node).addClass("producto_"+cant_items).attr("id", cant_items);
					if (data[0].fields.exento == false){
						updatePrice(data[1].fields.precio_unitario, 0);    
					} else {
						updatePrice(data[1].fields.precio_unitario, 1);
					} 
					
					select_element_sp(new_node);
				}else{
					cant_items++;
					pk_filled = paddy(data[0].pk, 5);
					pk_combo = pk_filled;
					new_node_cmb = table.row.add(["C-"+pk_filled, data[0].fields.nombre+"-"+data[1].fields.tamano, data[1].fields.precio]).draw().node();
					updatePrice(data[1].fields.precio, 0);
					$(new_node_cmb).addClass("combo_"+cant_items).attr("id", cant_items);
					for(var i = 2; i<data.length; i = i+2){
						pk_prod = paddy(data[i].pk, 5);
						var new_node = table.row.add(["P-"+pk_prod, data[i].fields.nombre+"-"+data[i+1].fields.tamano, ""]).draw().node(); //data[i+1].fields.precio_unitario
						$(new_node).addClass("combo_"+cant_items).attr("id", cant_items);
						select_element_p(new_node);
					}
					select_element(new_node_cmb);
				}
				$("#cant_items").val(cant_items);
			},
			error: function(xhr,errmsg,err) {
				//console.log(xhr.status + ": " + xhr.responseText);
				console.log(err);
			}
		});
	});

	$(".add_modi").click(function(){
		if (!$('.dataTables_empty').length) {
			if ($('.selected').length) {
				var all_selected = table.rows('.selected').nodes();
				var data = [];
				var num = 0;
				$.each(all_selected, function () {
					num++;
					var codigo = $(this).children("td:eq(0)").html();
					data.push(codigo);
				});
				// var all_selected = table.rows.add(["P-00XX", "ejemplo", "000.00"]).draw().nodes();
				var modal_modificadores = $(".panel-modificadores");
				var modal_extras = $(".panel-extras");
				modal_modificadores.html("");
				modal_extras.html("");
				$.ajax({
					data: {"codigos": data},
					url: '/add_mods_ajax/',
					type: 'POST',
					dataType: 'json',
					success: function (data) {
						var count = 0;
						$.each(data, function () {
							var pk = paddy(this.codigo, 5);
							if(this.tipo == "M"){
								modal_modificadores.append("<button class='shortcut-button primary mod margin5'><span class='badge'>M-" + pk + "</span><span class='title'>" + this.nombre.capitalize() + "</span><input type='hidden' class='precio' value='" + this.precio + "'></button>");
							}else{
								modal_extras.append("<button class='shortcut-button primary mod margin5'><span class='badge'>E-" + pk + "</span><span class='title'>" + this.nombre.capitalize() + "</span><input type='hidden' class='precio' value='" + this.precio + "'></button>");
							}
						});
						$(".mod").on("click", function () {
							var boton = $(this);
							var bot_cod = boton.children("span.badge").html();
							var bot_nom = boton.children("span.title").html();
							var bot_prec = boton.children("input.precio").val();
							var all_data = table.rows().nodes();
							var all_selected = table.rows('.selected').nodes();
							table.rows().remove().draw();
							var pk_combo = 0;
							var count = 0;
							var combo_line = 0;
							var node = 0;
							var id_cmb = "";
							var limit = "";
							var num_ele = all_selected.length;
							$.each(all_data, function (index) {
								if ($(this).hasClass("selected")) { // si la linea esta seleccionada
									var pk_line = $(this).children("td:eq(0)").html();
									combo_line = $(this).attr("id");
									$(this).removeClass("selected");
									var p_class = String($(this).attr("class"));
									p_class = p_class.replace("selected", "");
									if(p_class.startsWith("combo_")){
										id_cmb = $(this).attr('id');
									}
									if (pk_line.startsWith("C-")){ // si la linea es combo
										var bot_cod_this =  $(this).children("td:eq(0)").html();
										var bot_nom_this = $(this).children("td:eq(1)").html();
										var bot_prec_this = $(this).children("td:eq(2)").html();
										var cmb_n = table.row.add([bot_cod_this, bot_nom_this, bot_prec_this]).draw().node();
										$(cmb_n).addClass(p_class).attr("id", $(this).attr("id"));
										//table.row.add(this).draw().node();
										id_cmb = $(this).attr("id");
										limit = index;
										select_element(cmb_n);
										$('.cha_modi').prop('disabled', false).addClass('primary');
									}else if(pk_line.startsWith("P-")) { // si la linea es producto
										if(id_cmb != ""){ //  Si es producto y parte del combo
											table.row.add(this).draw().node();
											if(num_ele>1){
												if(id_cmb == $(this).attr("id") && index == (limit+num_ele-1)){ // cuando es combo completo
													var node_op = table.row.add([bot_cod, bot_nom, bot_prec]).draw().node();
													cant_items++;
													updatePrice(bot_prec, 0);
													if (p_class.startsWith("P-") || p_class.startsWith("C-")) {
														$(node_op).addClass(pk_line);
													} else {
														$(node_op).addClass(p_class);
													}
													//$(node).addClass("selected");
													$(node_op).attr("id", combo_line);
													$(node_op).click(function () {
														$('.del_modi').prop('disabled', false).addClass('danger');
														if($(this).hasClass('selected')){
															var num = table.rows('.selected').nodes();
															$.each(table.rows('.selected').nodes(), function () {
																$(this).removeClass("selected");
															});
															if(num.length != 1){
																$(this).addClass("selected");
															}
														}else{
															$.each(table.rows('.selected').nodes(), function () {
																$(this).removeClass("selected");
															});
															$(this).addClass("selected");
														}
													});
													$('.del_modi').prop('disabled', false).addClass('danger');
												}
											}else{
												var node_op = table.row.add([bot_cod, bot_nom, bot_prec]).draw().node();
												cant_items++;
												updatePrice(bot_prec, 0);
												if (p_class.startsWith("P-") || p_class.startsWith("C-")) {
													$(node_op).addClass(pk_line);
												} else {
													$(node_op).addClass(p_class);
												}
												//$(node).addClass("selected");
												$(node_op).attr("id", combo_line);
												select_element_sp(node_op);
												/*$(node_op).click(function () {
													$('.del_modi').prop('disabled', false).addClass('danger');
													if($(this).hasClass('selected')){
														var num = table.rows('.selected').nodes();
														$.each(table.rows('.selected').nodes(), function () {
															$(this).removeClass("selected");
														});
														if(num.length != 1){
															$(this).addClass("selected");
														}
													}else{
														$.each(table.rows('.selected').nodes(), function () {
															$(this).removeClass("selected");
														});
														$(this).addClass("selected");
													}
												});*/
												$('.del_modi').prop('disabled', false).addClass('danger');
											}
										}else{ // si es solo un producto
											var bot_cod_po =  $(this).children("td:eq(0)").html();
											var bot_nom_po = $(this).children("td:eq(1)").html();
											var bot_prec_po = $(this).children("td:eq(2)").html();
											var node_prd_m = table.row.add([bot_cod_po, bot_nom_po, bot_prec_po]).draw().node();
											$(node_prd_m).addClass(p_class).attr("id", $(this).attr("id"));
											select_element(node_prd_m);
											node = table.row.add([bot_cod, bot_nom, bot_prec]).draw().node();
											cant_items++;
											updatePrice(bot_prec, 0);
											if (p_class.startsWith("P-") || p_class.startsWith("C-")) {
												$(node).addClass(pk_line);
											} else {
												$(node).addClass(p_class);
											}
											//$(node).addClass("selected");
											$(node).attr("id", combo_line);
											select_element_p(node);
											/*$(node).click(function () {
												$('.del_modi').prop('disabled', false).addClass('danger');
												if($(this).hasClass('selected')){
													var num = table.rows('.selected').nodes();
													$.each(table.rows('.selected').nodes(), function () {
														$(this).removeClass("selected");
													});
													if(num.length != 1){
														$(this).addClass("selected");
													}

												}else{
													$.each(table.rows('.selected').nodes(), function () {
														$(this).removeClass("selected");
													});
													$(this).addClass("selected");
												}
											});*/
											$('.del_modi').prop('disabled', false).addClass('danger');
										}
									}else if(pk_line.startsWith("M-") || pk_line.startsWith("E-")){ // si es modificador
										var node_m = table.row.add(this).draw().node();

										if(id_cmb == $(this).attr("id") && index == (limit+num_ele-1)){
											var node = table.row.add([bot_cod, bot_nom, bot_prec]).draw().node();
											cant_items++;
											updatePrice(bot_prec, 0);
											if (p_class.startsWith("P-") || p_class.startsWith("C-")) {
												$(node).addClass(pk_line);
											} else {
												$(node).addClass(p_class);
											}
											//$(node).addClass("selected");
											$(node).attr("id", combo_line);
											$(node).click(function () {
												$('.del_modi').prop('disabled', false).addClass('danger');
												if($(this).hasClass('selected')){
													var num = table.rows('.selected').nodes();
													$.each(table.rows('.selected').nodes(), function () {
														$(this).removeClass("selected");
													});
													if(num.length != 1){
														$(this).addClass("selected");
													}
												}else{
													$.each(table.rows('.selected').nodes(), function () {
														$(this).removeClass("selected");
													});
													$(this).addClass("selected");
												}
											});
										}
									}
								} else {
									table.row.add(this).draw().node();
								}
							});
							hideMetroDialog("#modificador");
						});
					},
					error: function (xhr, errmsg, err) {
						//console.log(xhr.status + ": " + xhr.responseText);
						console.log(err);
					}
				});
				showDialog('#modificador');
			}
		}

	});

	function ajaxBorrada(row){
		var cod = $(row).children("td:eq(0)").html();
		var split_cod = cod.split("-");
		var cod_combo = 0;
		var cod_producto = 0;
		var cod_modificador = 0;
		if(split_cod[0]=="C"){
			cod_combo = parseInt(split_cod[1]);
			cod_producto = 0;
			cod_modificador = 0;
		}else if(split_cod[0]=="P"){
			cod_combo = 0;
			cod_modificador = 0;
			cod_producto = parseInt(split_cod[1]);
		}else{
			cod_combo = 0;
			cod_modificador = parseInt(split_cod[1]);
			cod_producto = 0;
		}
		var cod_venta = $("#venta").val();
		var usuario = $("#usuario").val();
		var establecimiento = $("#establecimiento").val();
		var monto = parseFloat($(row).children("td:eq(2)").html());
		$.ajax({
			data: { 'usuario': usuario,
				'establecimiento': establecimiento,
				'cod_combo': cod_combo,
				'cod_producto': cod_producto,
				'cod_modificador': cod_modificador,
				'monto': monto,
				'venta': cod_venta},
			url: '/agregar_borrada_ajax/',
			type: 'get',
			error: function(xhr,errmsg,err) {
				//console.log(xhr.status + ": " + xhr.responseText);
				console.log(err);
			}
		});
	}

	function borrar(obj){
		var total = parseFloat($(".fac-total").html());
		var sub_total = parseFloat($(".fac-sub-total").html());
		var iva = parseFloat($(".fac-iva").html());
		var sub_tot = parseFloat($(obj).children("td:eq(2)").html()) - get_iva(parseFloat($(obj).children("td:eq(2)").html()));
		var tot = parseFloat($(obj).children("td:eq(2)").html());
		var iv = get_iva($(obj).children("td:eq(2)").html());
		total = total - tot;
		sub_total = sub_total - sub_tot;
		iva = iva - iv;
		$(".fac-total").html(total.toFixed(2));
		$(".fac-sub-total").html(sub_total.toFixed(2));
		$(".fac-iva").html(iva.toFixed(2));
		ajaxBorrada(obj);
	}

	$(".del_modi").click(function(){
		var all_selected = table.rows('.selected').nodes();
		var codigo_com = "";
		var first = 0;
		$.each(all_selected, function(){
			var codigo = $(this).children("td:eq(0)").html();
			var class_item = $(this).attr("class");
			var id_item = $(this).attr("id");
			if($(this).hasClass("combo_"+id_item) || $(this).hasClass("producto_"+id_item)){
				if(first == 0){
					borrar(this);
					first = 1;
				}
				table.rows(this).remove().draw();
			}else{
				borrar(this);
				table.rows(this).remove().draw();
			}
		});
	});

	$(".cha_modi").click(function(){
		if (!$('.dataTables_empty').length) {
			if ($('.selected').length) {
				var all_selected = table.rows('.selected').nodes();
				var data = [];
				var num = 0;
				$.each(all_selected, function () {
					num++;
					var codigo = $(this).children("td:eq(0)").html();
					data.push(codigo);
				});
				var modal_modificadores = $(".panel-cha-productos");
				modal_modificadores.html("");
				$.ajax({
					data: {"codigos": data},
					url: '/cha_prds_ajax/',
					type: 'POST',
					dataType: 'json',
					success: function (data) {
						var model = data[0].model;
						if(model == "index.productos"){
							for(var i = 0; i<(data.length/2); i++){
								var pk = paddy(data[i].pk, 5);
								modal_modificadores.append("<button class='shortcut-button primary mod margin5'><span class='badge'>P-" + pk + "</span><span class='title'>" + data[i].fields.nombre.capitalize() + "</span><input type='hidden' class='tamanio' value='"+data[i+(data.length/2)].fields.tamano+"'></button>");
							}
						}else{
							for(var i = 0; i<(data.length); i++){
								var pk = paddy(data[i].pk, 5);
								modal_modificadores.append("<button class='shortcut-button primary mod margin5'><span class='badge'>M-" + pk + "</span><span class='title'>" + data[i].fields.nombre.capitalize() + "</span><input type='hidden' class='precio' value='"+data[i].fields.precio+"'></button>");
							}
						}
						$(".mod").on("click", function () {
							var boton = $(this);
							var bot_cod = boton.children("span.badge").html();
							var bot_nom = boton.children("span.title").html();
							var bot_prec = "";
							if(model == "index.productos"){
								bot_prec = boton.children("input.tamanio").val();
							}else{
								bot_prec = boton.children("input.precio").val();
							}
							var all_data = table.rows().nodes();
							var all_selected = table.row('.selected').node();
							table.rows().remove().draw();
							var combo_line = 0;
							var id_cmb = boton.attr("id");
							var limit = "";
							var num_ele = all_selected.length;
							$.each(all_data, function (index) {
								if ($(this).hasClass("selected")) { // si la linea esta seleccionada
									var pk_line = $(this).children("td:eq(0)").html();
									combo_line = $(this).attr("id");
									$(this).removeClass("selected");
									var p_class = String($(this).attr("class"));
									p_class = p_class.replace("selected", "");
									var pk_selected = $(all_selected).children("td:eq(0)").html();
									if(pk_line.startsWith("P-")) { // si la linea es producto
										if(pk_line == pk_selected){
											var node_op = table.row.add([bot_cod, bot_nom+"-"+bot_prec, ""]).draw().node();
											cant_items++;
											if (p_class.startsWith("P-") || p_class.startsWith("C-")) {
												$(node_op).addClass(pk_line);
											} else {
												$(node_op).addClass(p_class);
											}
											$(node_op).attr("id", combo_line);
											select_element_p(node_op);
										}
									}else if(pk_line.startsWith("M-") || pk_line.startsWith("E-")){ // si es modificador
										borrar(this);
										if(pk_line == pk_selected){
											var node = table.row.add([bot_cod, bot_nom, bot_prec]).draw().node();
											cant_items++;
											updatePrice(bot_prec, 0);
											if (p_class.startsWith("P-") || p_class.startsWith("C-")) {
												$(node).addClass(pk_line);
											} else {
												$(node).addClass(p_class);
											}
											$(node).attr("id", combo_line);
											$(node).click(function () {
												$('.del_modi').prop('disabled', false).addClass('danger');
												if($(this).hasClass('selected')){
													var num = table.rows('.selected').nodes();
													$.each(table.rows('.selected').nodes(), function () {
														$(this).removeClass("selected");
													});
													if(num.length != 1){
														$(this).addClass("selected");
													}
												}else{
													$.each(table.rows('.selected').nodes(), function () {
														$(this).removeClass("selected");
													});
													$(this).addClass("selected");
												}
											});
										}
									}
								} else {
									table.row.add(this).draw().node();
								}
							});
							hideMetroDialog("#change");
						});
					},
					error: function (xhr, errmsg, err) {
						//console.log(xhr.status + ": " + xhr.responseText);
						console.log(err);
					}
				});
				showDialog('#change');
			}
		}
	});

	$(".confirm").click(function () {
		var all_rows = table.rows().nodes();
		var total = $(".fac-total").html();
		var sub_total = $(".fac-sub-total").html();
		var iva = $(".fac-iva").html();
		var cod_venta = $("#venta").val();
		var usuario = $("#usuario").val();
		var establecimiento = $("#establecimiento").val();
		var doc_cliente = $(".sel-doc").val()+$(".num-doc").val();
		var nom_cliente = $(".cli-nom").val();
		var ape_cliente = $(".cli-ape").val();
		var dir_cliente = $(".cli-dir").val();
		var pagos = [];
		var pagos_total = $("#inp_cant1").val();
		var pagos_table = $(".pagos").children("div:visible");
		pagos.push({forma: $("#metodo_p_id").val(), monto: $("#inp_cant1").val()});
		/*$.each(pagos_table, function(){
			var mp_id = $(this).children("div").children("select").find(":selected").val();
			var cant = parseFloat($(this).children("div").children("input").val());
			pagos_total += cant;
			pagos.push({forma: mp_id, monto: cant});
		});*/
		var data = [];
		$.each(all_rows, function (index) {
			var cod = $(this).children("td:eq(0)").html();
			var nom = $(this).children("td:eq(1)").html();
			var cost = $(this).children("td:eq(2)").html();
			var id_item = $(this).attr("id");
			var item = {codigo: cod, id_item: id_item, nombre: nom};
			data.push(item);
		});
		var cambio = pagos_total - parseFloat(sub_total);
		$("#monto-cambio").html(cambio.toFixed(2));
		if(cambio >= 0.00){

			$.ajax({
				data: JSON.stringify({ 'usuario': usuario,
					'establecimiento': establecimiento,
					'items': data,
					'pagos': pagos,
					'total': sub_total,
					'subtotal': sub_total,
					'iva': iva,
					'venta': cod_venta,
					'cli_doc': doc_cliente,
					'cli_nom': nom_cliente,
					'cli_ape': ape_cliente,
					'cli_dir': dir_cliente
				}),
				url: '/venta_ajax/',
				type: 'POST',
				dataType: 'json',
				success: function (data){
					if(data[0].status != "ok"){
						$("#search-info").hide();
						$("#impress-warn").show();
						setTimeout(function() {
							$("#impress-warn").hide();
						}, 5000);
						console.log(data[0].log);
					}else{
						
					}
				},
				error: function(xhr, errmsg, err) {
					//console.log(xhr.status + ": " + xhr.responseText);
					console.log(err);
				}
			});
			hideMetroDialog('#aceptar');
			showDialog('#cambio');
		}else{
			$('#change-error').show();
			setTimeout(function(){
				$('#change-error').hide();
			}, 5000);
		}
	});

	$(".buscar").click(function() {
		var tipo_doc = $(".sel-doc").val();
		var numero_doc = $(".num-doc").val();
		var documento = tipo_doc+numero_doc;
		$.ajax({
			data: {'documento': documento},
			url: '/get_client_ajax/',
			type: 'POST',
			dataType: 'json',
			success: function(data) {
				if(data[0].status == "ok"){
					$(".cli-nom").val(data[0].nombre);
					$(".cli-ape").val(data[0].apellido);
					$(".cli-dir").val(data[0].direccion);
				}else{
					$("#impress-warn").hide();
					$("#search-info").show();
					setTimeout(function(){
						$("#search-info").hide();
					}, 5000);
				}
			},
			error: function(xhr, errmsg, err) {
				//console.log(xhr.status + ": " + xhr.responseText);
				console.log(err);
			}
		});
	});

	$(".up_prod, .down_prod").click(function(){
		var all_selected = table.rows('.selected').nodes();
		var data = [];
		var num = 0;
		$.each(all_selected, function(){
			num ++;
			var codigo = $(this).children("td:eq(0)").html();
			var nombre = $(this).children("td:eq(1)").html();
			var tamano = nombre.split("-");
			data.push({codigo: codigo, tamano: tamano[1]});
		});
		var mode = "";
		if($(this).hasClass("up_prod")){
			mode = "1";
		}else{
			mode = "0";
		}
		$.ajax({
			data: JSON.stringify({items: data, mode: mode}),
			url: '/aument_ajax/',
			type: 'POST',
			dataType: 'json',
			success: function (data) {
				var count = 0;
				var all_data = table.rows().nodes();
				table.rows().remove().draw();
				$.each(all_data, function (index) {
					if($(this).hasClass("selected")){
						var id_row = $(this).attr("id");
						var cod = $(this).children("td:eq(0)").html();
						var name = $(this).children("td:eq(1)").html();
						var old_price = $(this).children("td:eq(2)").html();
						var split_old = name.split("-");
						for(var i = 0; i < data.length; i++){
							if($(this).children("td:eq(0)").html() == data[i].codigo){
								var p_class = String($(this).attr("class"));
								p_class = p_class.replace("selected", "");
								var new_price = data[i].precio;
								var new_name = data[i].tamano;
								var final_name = split_old[0]+"-"+new_name;
								if(data[i].error == "0"){
									var node = table.row.add([cod, final_name, new_price]).draw().node();
									if (data[i].exento == true){
										updatePriceDown(old_price, 1);
										updatePrice(new_price, 1);
									} else {
										updatePriceDown(old_price, 0);
										updatePrice(new_price, 0);                                        
									}
									$(node).addClass(p_class);
									$(node).attr("id", id_row);
								}else{
									table.row.add(this).draw();
									$.Notify({
										caption: 'Error',
										content: 'No es posible cambiar el tamaño del producto',
										type: 'alert',
										shadow: true,
										timeout: 5000
									});
								}
							}
						}
					}else{
						table.row.add(this).draw();
					}
				});
			},
			error: function(xhr, errmsg, err) {
				//console.log(xhr.status + ": " + xhr.responseText);
				console.log(err);
			}
		});
		//showDialog('#modificador');
	});

	$('.refresh').click(function(){
		window.location.replace("/app");
		showDialog('#metodo_pago');
	});

	$(".end").click(function () {
		window.location.replace("/app");
		showDialog('#metodo_pago');
	});

	$(".buscar_fact").click(function () {
		var usuario = $("#usuario").val();
		var establecimiento = $("#establecimiento").val();
		var nfact_input = $(".val-nfac").val();
		var factura = paddy(nfact_input, 8);
		$.ajax({
			data: {'factura': factura, 'establecimiento': establecimiento, 'usuario': usuario},
			url: '/search_factura_ajax/',
			type: 'POST',
			dataType: 'json',
			success: function(data) {
				if(data[0].status == "ok"){
					$("#nom-cliente").val(data[0].nombre);
					$("#mont-fact").val(data[0].monto);
					$("#docu-cliente").val(data[0].documento);
					$("#fecha-fact").val(data[0].fecha);
					$("#nro-fact").val(data[0].nrofact);
					$(".confirm-dev").removeAttr("disabled").addClass('primary');
				}else{
					$("#impress-warn-rev").hide();
					$("#search-info-rev").show();
					$(".confirm-dev").attr("disabled", "disabled").removeClass('primary');
					setTimeout(function(){
						$("#search-info-rev").hide();
					}, 5000);
				}
			},
			error: function(xhr, errmsg, err) {
				console.log(xhr.status + ": " + xhr.responseText);
			}
		});
	});

	$(".confirm-dev").click(function () {
		var usuario = $("#usuario").val();
		var establecimiento = $("#establecimiento").val();
		var nfact_input = $(".val-nfac").val();
		var factura = paddy(nfact_input, 8);
		$.ajax({
			data: {'factura': factura, 'establecimiento': establecimiento, 'usuario': usuario},
			url: '/reverse_factura_ajax/',
			type: 'POST',
			dataType: 'json',
			success: function(data) {
				if(data[0].status == "ok"){
					hideMetroDialog('#devolucion');
				}else if(data[0].status == "Not Found") {
					$("#search-info-rev").show();
					$("#impress-warn-rev").hide();
					$("#rev-exist").hide();
					setTimeout(function () {
						$("#search-info-rev").hide();
					}, 5000);
				}else if(data[0].status == "Already Exist"){//					
					$("#rev-exist").show();
					$("#impress-warn-rev").hide();
					$("#search-info-rev").hide();
					setTimeout(function () {
						$("#rev-exist").hide();
					}, 5000);
				}else{
					$("#impress-warn-rev").show();
					$("#rev-exist").hide();
					$("#search-info-rev").hide();
					setTimeout(function () {
						$("#impress-warn-rev").hide();
					}, 5000);
				}
			},
			error: function(xhr, errmsg, err) {
				//console.log(xhr.status + ": " + xhr.responseText);
				console.log(err);
			}
		});
	});

	$(".reportez").click(function () {
		var usuario = $("#usuario").val();
		var establecimiento = $("#establecimiento").val();
		$.ajax({
			data: {'establecimiento': establecimiento, 'usuario': usuario},
			url: '/reporte_z_ajax/',
			type: 'POST',
			dataType: 'json',
			success: function(data) {
				if(data[0].status == "ok"){
					$(".cli-nom").val(data[0].nombre);
					$(".cli-ape").val(data[0].apellido);
					$(".cli-dir").val(data[0].direccion);
				}else if(data[0].status == "Not Found"){
					$("#impress-warn-rev").hide();
					$("#search-info-rev").show();
					setTimeout(function(){
						$("#search-info-rev").hide();
					}, 5000);
				}else{
					$("#impress-warn-rev").show();
					$("#search-info-rev").hide();
				}
			},
			error: function(xhr, errmsg, err) {
				//console.log(xhr.status + ": " + xhr.responseText);
				console.log(err);
			}
		});
	});

	$(".reportex").click(function () {
		var usuario = $("#usuario").val();
		var establecimiento = $("#establecimiento").val();
		$.ajax({
			data: {'establecimiento': establecimiento, 'usuario': usuario},
			url: '/reverse_factura_ajax/',
			type: 'POST',
			dataType: 'json',
			success: function(data) {
				if(data[0].status == "ok"){
					$(".cli-nom").val(data[0].nombre);
					$(".cli-ape").val(data[0].apellido);
					$(".cli-dir").val(data[0].direccion);
				}else if(data[0].status == "Not Found"){
					$("#impress-warn-rev").hide();
					$("#search-info-rev").show();
					setTimeout(function(){
						$("#search-info-rev").hide();
					}, 5000);
				}else{
					$("#impress-warn-rev").show();
					$("#search-info-rev").hide();
				}
			},
			error: function(xhr, errmsg, err) {
				//console.log(xhr.status + ": " + xhr.responseText);
				console.log(err);
			}
		});
	});
	$(".cash, .electronic").click(function () {
		$("#metodo_p").val($(this).attr('name'));
		$("#metodo_p_id").val($(this).attr('id'));
		hideMetroDialog('#metodo_pago');
	});
});
