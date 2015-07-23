//aad
var lineas = 0;
var otrosimptos = 0;
var decimales = 3;

function setDecimales(decs){
	this.decimales = decs;
}

function formatMoney(number, decPlaces, thouSeparator, decSeparator) {
    var n = number,
    decPlaces = isNaN(decPlaces = Math.abs(decPlaces)) ? decimales : decPlaces,
    decSeparator = decSeparator == undefined ? "." : decSeparator,
    thouSeparator = thouSeparator == undefined ? "," : thouSeparator,
    sign = n < 0 ? "-" : "",
    i = parseInt(n = Math.abs(+n || 0).toFixed(decPlaces)) + "",
    j = (j = i.length) > 3 ? j % 3 : 0;
    return sign + (j ? i.substr(0, j) + thouSeparator : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thouSeparator) + (decPlaces ? decSeparator + Math.abs(n - i).toFixed(decPlaces).slice(2) : "");
};

function mostrarOtrosImp(){
	otrosimptos = 1;
	$(".visible").remove();
	$(".oculto").removeClass( "hidden oculto" );
}

function calcTotales(){
	
	var subtotal = 0;
	var subtotal_desc = 0;
	var ivatrasladado = 0;
	var iepstrasladado = 0;
	var ivaretenido = 0;
	var isrretenido = 0;
	var pordesc = 0;
	var descuento = 0;
	var total = 0;
	
	pordesc = $("#descuento").val();
	if(pordesc > 100){
		$("#descuento").val("0");
		pordesc = 0;
	}
	
	$("#conceptos > tr").each(function(e, lin){
		
		var importe = parseFloat($(lin).find(".importe").html());
		var importe_desc = importe - (importe*pordesc/100);
		subtotal += importe;
		subtotal_desc += importe_desc;
		
		ivatrasladado += (importe_desc*parseFloat($(lin).find(".ivatrasladado").val())/100);
		iepstrasladado += (importe_desc*parseFloat($(lin).find(".iepstrasladado").val())/100);
		ivaretenido += (importe_desc*parseFloat($(lin).find(".ivaretenido").val())/100);
		isrretenido += (importe_desc*parseFloat($(lin).find(".isrretenido").val())/100);
		
	});
	
	descuento = (subtotal*pordesc/100);
	
	total = (isNaN(subtotal_desc) ? 0 : subtotal_desc) + (isNaN(ivatrasladado) ? 0 : ivatrasladado) + (isNaN(iepstrasladado) ? 0 : iepstrasladado) - (isNaN(ivaretenido) ? 0 : ivaretenido) - (isNaN(isrretenido) ? 0 : isrretenido);
	
	$("#subtotal").html(formatMoney(subtotal,decimales,',', '.'));
	$("#totdescuento").html(formatMoney(descuento,decimales,',', '.'));
	$("#totivatrasladado").html(formatMoney(ivatrasladado,decimales,',', '.'));
	$("#totiepstrasladado").html(formatMoney(iepstrasladado,decimales,',', '.'));
	$("#totivaretenido").html(formatMoney(ivaretenido,decimales,',', '.'));
	$("#totisrretenido").html(formatMoney(isrretenido,decimales,',', '.'));
	$("#total").html(formatMoney(total,decimales,',', '.'));
	
}

function calcImporte(linea){
	var cantidad = parseFloat($("#cantidad"+linea).val());
	var valorunitario = parseFloat($("#valorunitario"+linea).val());
	
	var importe = (cantidad * valorunitario);
	
	//$("#importe"+linea).html(formatMoney(importe,2,',', '.'));
	$("#importe"+linea).html(importe.toFixed(decimales));
	calcTotales();
}

function autoComp(){
	$( ".concepto" ).autocomplete({
	  source: "/productos.json",
	  minLength: 3,
	  select: function( event, ui ) {
			event.preventDefault();
			this.value = ui.item.nombre;
		
			var linea = $(this).attr("linea");
			
			//console.log(ui.item);
			
			$("#cantidad"+linea).val("1");
			$("#codigo"+linea).val(ui.item.codigobarras);
			$("#costo"+linea).val(ui.item.precio);
			$("#valorunitario"+linea).val(ui.item.precio);
			$("#unidad"+linea).val(ui.item.unidad.nombre);
			$("#ivatrasladado"+linea).val(ui.item.ivatrasladado);
			$("#iepstrasladado"+linea).val(ui.item.iepstrasladado);
			$("#ivaretenido"+linea).val(ui.item.ivaretenido);
			$("#isrretenido"+linea).val(ui.item.isrretenido);
			$("#cantidad"+linea).focus();
			
			str = "";
			prec = ui.item.precios;
			
			var cliente_listadeprecio = $("#cliente_listadeprecio").val();
			
	        for(key in prec){
				
				if(cliente_listadeprecio == prec[key].listadeprecio_id){
					str += "<option value='"+prec[key].precio+"' SELECTED>"+formatMoney(prec[key].precio,decimales,',', '.')+"</option>";
				}else {
					str += "<option value='"+prec[key].precio+"'>"+formatMoney(prec[key].precio,decimales,',', '.')+"</option>";
				}
	        }
	        $("#vunitselect"+linea).html(str);
			
			calcImporte(linea);
		}
	});
	
	$( ".codigo" ).autocomplete({
	  source: "/productos.json?codbarras=true",
	  minLength: 1,
		
		response: function( event, ui ) {
		      if (ui.content.length == 1)
		      {
						
								ui.item = ui.content[0];
								$(this).data('ui-autocomplete')._trigger('select', 'autocompleteselect', ui);
		            $(this).autocomplete( "close" );
		       }
		},
		
		//autoFocus: true,
	  select: function( event, ui ) {
			event.preventDefault();
			this.value = ui.item.codigobarras;
			
			var linea = $(this).attr("linea");
			
			//console.log(ui.item);
			
			$("#cantidad"+linea).val("1");
			$("#descripcion"+linea).val(ui.item.nombre);
			$("#costo"+linea).val(ui.item.precio);
			$("#valorunitario"+linea).val(ui.item.precio);
			$("#unidad"+linea).val(ui.item.unidad.nombre);
			$("#ivatrasladado"+linea).val(ui.item.ivatrasladado);
			$("#iepstrasladado"+linea).val(ui.item.iepstrasladado);
			$("#ivaretenido"+linea).val(ui.item.ivaretenido);
			$("#isrretenido"+linea).val(ui.item.isrretenido);
			$("#cantidad"+linea).focus();
			
			str = "";
			prec = ui.item.precios;
			
			var cliente_listadeprecio = $("#cliente_listadeprecio").val();
			
	        for(key in prec){
				
				if(cliente_listadeprecio == prec[key].listadeprecio_id){
					str += "<option value='"+prec[key].precio+"' SELECTED>"+formatMoney(prec[key].precio,decimales,',', '.')+"</option>";
				}else {
					str += "<option value='"+prec[key].precio+"'>"+formatMoney(prec[key].precio,decimales,',', '.')+"</option>";
				}
	        }
	        $("#vunitselect"+linea).html(str);
			setPrecio(linea);
			calcImporte(linea);
		}
	});
	
}

function removerLinea(linea){
	$(linea).parent().parent().remove();
	calcTotales();
}

function precioManual(linea){
	
	setPrecio(linea);
	$("#vunitselect"+linea).addClass("hidden");
	$("#btnPrecioManual"+linea).addClass("hidden");
	$("#valorunitario"+linea).removeClass( "hidden" );
	
}

function setPrecio(linea){
	
	var valor = parseFloat($("#vunitselect"+linea).val());
	$("#valorunitario"+linea).val(valor);
	calcImporte(linea);
	
}

function agregarLinea(){
	
	var nvalinea = '<tr>'+
          		'<td class="col-md-1"><strong>Codigo</strong><input class="codigo form-control" linea="'+lineas+'" id="codigo'+lineas+'" name="remision[conceptos_attributes][][codigo]" type="text"><br /><div class="btn btn-danger" onclick="removerLinea(this)"><span class="glyphicon glyphicon-remove"></span></div><input type="hidden" name="remision[conceptos_attributes][][costo]" value"" linea="'+lineas+'" id="costo'+lineas+'" /></td>'+
  				'<td class="col-md-6"><textarea class="concepto form-control" linea="'+lineas+'" id="descripcion'+lineas+'" name="remision[conceptos_attributes][][descripcion]" placeholder="Producto o Descripcion"></textarea></td>'+
  				'<td class="col-md-2"><input onkeyUp="calcImporte('+lineas+');" class="hidden valorunitario form-control text-right" id="valorunitario'+lineas+'" name="remision[conceptos_attributes][][valorunitario]" type="text"><select id="vunitselect'+lineas+'" onChange="setPrecio('+lineas+');"></select>&nbsp;<div id="btnPrecioManual'+lineas+'" class="btn btn-default btn-sm" onclick="precioManual('+lineas+');"><span class="glyphicon glyphicon-edit">Manual</span></div></td>'+
          	  	'<td class="col-md-1"><input onkeyUp="calcImporte('+lineas+');" class="cantidad form-control text-right" id="cantidad'+lineas+'" name="remision[conceptos_attributes][][cantidad]" type="text"></td>'+
  				'<td class="col-md-1"><input class="unidad form-control" id="unidad'+lineas+'" name="remision[conceptos_attributes][][unidad]" type="text"></td>'+
				'<td class="col-md-2"><input onkeyUp="calcImporte('+lineas+');" class="ivatrasladado form-control text-right" id="ivatrasladado'+lineas+'" name="remision[conceptos_attributes][][ivatrasladado]" type="text"></td>'+
				'<td class="hidden oculto col-md-2"><input onkeyUp="calcImporte('+lineas+');" class="iepstrasladado form-control text-right" id="iepstrasladado'+lineas+'" name="remision[conceptos_attributes][][iepstrasladado]" type="text"></td>'+
				'<td class="hidden oculto col-md-2"><input onkeyUp="calcImporte('+lineas+');" class="ivaretenido form-control text-right" id="ivaretenido'+lineas+'" name="remision[conceptos_attributes][][ivaretenido]" type="text"></td>'+
				'<td class="hidden oculto col-md-2"><input onkeyUp="calcImporte('+lineas+');" class="isrretenido form-control text-right" id="isrretenido'+lineas+'" name="remision[conceptos_attributes][][isrretenido]" type="text"></td>'+
				'<td class="visible">&nbsp;</td>'+
          	  	'<td class="col-lg-2"><p id="importe'+lineas+'" name="remision[conceptos_attributes][][importe]" class="importe lead text-right">$0.00</p></td>'+
			'</tr>';
	
	$("#conceptos").append(nvalinea);
	setPrecio(lineas);
	autoComp();
	lineas++;
}

function precargarLinea(codigo, descripcion, valorunitario, cantidad, unidad, ivatrasladado, iepstrasladado, ivaretenido, isrretenido){
	
	var nvalinea = '<tr>'+
          		'<td class="col-md-1"><strong>Codigo</strong><input class="codigo form-control" linea="'+lineas+'" id="codigo'+lineas+'" name="remision[conceptos_attributes][][codigo]" type="text" value="'+codigo+'"><br /><div class="btn btn-danger" onclick="removerLinea(this)"><span class="glyphicon glyphicon-remove"></span></div><input type="hidden" name="remision[conceptos_attributes][][costo]" value"" linea="'+lineas+'" id="costo'+lineas+'" /></td>'+
  				'<td class="col-md-6"><textarea class="concepto form-control" linea="'+lineas+'" id="descripcion'+lineas+'" name="remision[conceptos_attributes][][descripcion]" placeholder="Producto o Descripcion">' + descripcion + '</textarea></td>'+
  				'<td class="col-md-2"><input onkeyUp="calcImporte('+lineas+');" class="valorunitario form-control text-right" id="valorunitario'+lineas+'" name="remision[conceptos_attributes][][valorunitario]" type="text" value="'+valorunitario+'"></td>'+
          	  	'<td class="col-md-1"><input onkeyUp="calcImporte('+lineas+');" class="cantidad form-control text-right" id="cantidad'+lineas+'" name="remision[conceptos_attributes][][cantidad]" type="text" value="'+cantidad+'"></td>'+
  				'<td class="col-md-1"><input class="unidad form-control" id="unidad'+lineas+'" name="remision[conceptos_attributes][][unidad]" type="text" value="'+unidad+'"></td>'+
				'<td class="col-md-2"><input onkeyUp="calcImporte('+lineas+');" class="ivatrasladado form-control text-right" id="ivatrasladado'+lineas+'" name="remision[conceptos_attributes][][ivatrasladado]" type="text" value="'+ivatrasladado+'"></td>'+
				'<td class="hidden oculto col-md-2"><input onkeyUp="calcImporte('+lineas+');" class="iepstrasladado form-control text-right" id="iepstrasladado'+lineas+'" name="remision[conceptos_attributes][][iepstrasladado]" type="text" value="'+iepstrasladado+'"></td>'+
				'<td class="hidden oculto col-md-2"><input onkeyUp="calcImporte('+lineas+');" class="ivaretenido form-control text-right" id="ivaretenido'+lineas+'" name="remision[conceptos_attributes][][ivaretenido]" type="text" value="'+ivaretenido+'"></td>'+
				'<td class="hidden oculto col-md-2"><input onkeyUp="calcImporte('+lineas+');" class="isrretenido form-control text-right" id="isrretenido'+lineas+'" name="remision[conceptos_attributes][][isrretenido]" type="text" value="'+isrretenido+'"></td>'+
				'<td class="visible">&nbsp;</td>'+
          	  	'<td class="col-lg-2"><p id="importe'+lineas+'" name="remision[conceptos_attributes][][importe]" class="importe lead text-right">$0.00</p></td>'+
			'</tr>';
	
	$("#conceptos").append(nvalinea);
	autoComp();
	calcImporte(lineas);
	lineas++;
}

function init(){
	
	$.ui.autocomplete.prototype._renderItem = function (ul, item) {
	    return $( "<li>" )
	      .attr( "data-value", item.nombre )
	      .append( $( "<a>" ).text( item.nombre ) )
	      .appendTo( ul );
	};

	agregarLinea();
	autoComp();
	
	$("#agregar").click(function(){
		agregarLinea();
		if(otrosimptos==1){
			mostrarOtrosImp();
		}

	});

	$("#otrosimptos").click(function(){
		mostrarOtrosImp();
	});	
	
}

$(document).ready(function() {

		init();
	
});