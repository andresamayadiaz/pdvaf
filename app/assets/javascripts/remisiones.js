//aad
//AJAX Productos AutoComplete
/*
function( request, response ) {
	    $.ajax({
	      url: '/productos.json?q='+request.term,
	      dataType: "json",
	      success: function( data ) {
	        console.log(data);
	      }
	    });
},
*/
var lineas = 0;
var otrosimptos = 0;

function formatMoney(number, decPlaces, thouSeparator, decSeparator) {
    var n = number,
    decPlaces = isNaN(decPlaces = Math.abs(decPlaces)) ? 2 : decPlaces,
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
	
	var subtotal= 0;
	var ivatrasladado = 0;
	var iepstrasladado = 0;
	var ivaretenido = 0;
	var isrretenido = 0;
	var pordesc = 0;
	var descuento = 0;
	
	$("#conceptos > tr").each(function(e, lin){
		
		var importe = parseFloat($(lin).find(".importe").html());
		subtotal += importe;
		
		ivatrasladado += (importe*parseFloat($(lin).find(".ivatrasladado").val())/100);
		iepstrasladado += (importe*parseFloat($(lin).find(".iepstrasladado").val())/100);
		ivaretenido += (importe*parseFloat($(lin).find(".ivaretenido").val())/100);
		isrretenido += (importe*parseFloat($(lin).find(".isrretenido").val())/100);
		
	});
	
	pordesc = $("#descuento").val();
	descuento = (subtotal*pordesc/100);
	
	var total = subtotal + ivatrasladado + iepstrasladado - ivaretenido - isrretenido;
	
	$("#subtotal").html(formatMoney(subtotal,2,',', '.'));
	$("#descuento").html(formatMoney(descuento,2,',', '.'));
	$("#totivatrasladado").html(formatMoney(ivatrasladado,2,',', '.'));
	$("#totiepstrasladado").html(formatMoney(iepstrasladado,2,',', '.'));
	$("#totivaretenido").html(formatMoney(ivaretenido,2,',', '.'));
	$("#totisrretenido").html(formatMoney(isrretenido,2,',', '.'));
	$("#total").html(formatMoney(total,2,',', '.'));
	
}

function calcImporte(linea){
	var cantidad = parseFloat($("#cantidad"+linea).val());
	var punit = parseFloat($("#punit"+linea).val());
	
	var importe = (cantidad * punit);
	
	//$("#importe"+linea).html(formatMoney(importe,2,',', '.'));
	$("#importe"+linea).html(importe.toFixed(2));
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
		
			$("#cantidad"+linea).val("1");
			$("#punit"+linea).val(ui.item.precio);
			$("#unidad"+linea).val(ui.item.unidad.nombre);
			$("#ivatrasladado"+linea).val(ui.item.ivatrasladado);
			$("#iepstrasladado"+linea).val(ui.item.iepstrasladado);
			$("#ivaretenido"+linea).val(ui.item.ivaretenido);
			$("#isrretenido"+linea).val(ui.item.isrretenido);
			$("#cantidad"+linea).focus();
			calcImporte(linea);
		}
	});
}

function removerLinea(linea){
	$(linea).parent().parent().remove();
	calcTotales();
}

function agregarLinea(){
	
	var nvalinea = '<tr>'+
          		'<td class="col-md-1"><div class="btn btn-danger" onclick="removerLinea(this)"><span class="glyphicon glyphicon-remove"></span></button></td>'+
  				'<td class="col-md-6"><textarea class="concepto form-control" linea="'+lineas+'" id="concepto'+lineas+'" name="remision[conceptos]['+lineas+'][concepto]" placeholder="Producto o Descripcion"></textarea></td>'+
  				'<td class="col-md-2"><input onkeyUp="calcImporte('+lineas+');" class="punit form-control text-right" id="punit'+lineas+'" name="remision[conceptos]['+lineas+'][punit]" type="text"></td>'+
          	  	'<td class="col-md-1"><input onkeyUp="calcImporte('+lineas+');" class="cantidad form-control text-right" id="cantidad'+lineas+'" name="remision[conceptos]['+lineas+'][cantidad]" type="text"></td>'+
  				'<td class="col-md-2"><input class="unidad form-control" id="unidad'+lineas+'" name="remision[conceptos]['+lineas+'][unidad]" type="text"></td>'+
				'<td class="col-md-2"><input onkeyUp="calcImporte('+lineas+');" class="ivatrasladado form-control text-right" id="ivatrasladado'+lineas+'" name="remision[conceptos]['+lineas+'][ivatrasladado]" type="text"></td>'+
				'<td class="hidden oculto col-md-2"><input onkeyUp="calcImporte('+lineas+');" class="iepstrasladado form-control text-right" id="iepstrasladado'+lineas+'" name="remision[conceptos]['+lineas+'][iepstrasladado]" type="text"></td>'+
				'<td class="hidden oculto col-md-2"><input onkeyUp="calcImporte('+lineas+');" class="ivaretenido form-control text-right" id="ivaretenido'+lineas+'" name="remision[conceptos]['+lineas+'][ivaretenido]" type="text"></td>'+
				'<td class="hidden oculto col-md-2"><input onkeyUp="calcImporte('+lineas+');" class="isrretenido form-control text-right" id="isrretenido'+lineas+'" name="remision[conceptos]['+lineas+'][isrretenido]" type="text"></td>'+
				'<td class="visible">&nbsp;</td>'+
          	  	'<td class="col-lg-2"><p id="importe'+lineas+'" name="remision[conceptos]['+lineas+'][importe]" class="importe lead text-right">$0.00</p></td>'+
			'</tr>';
	
	$("#conceptos").append(nvalinea);
	autoComp();
	lineas++;
}

$(document).ready(function() {
	
	agregarLinea();
	autoComp();
	
	$.ui.autocomplete.prototype._renderItem = function (ul, item) {
	    return $( "<li>" )
	      .attr( "data-value", item.nombre )
	      .append( $( "<a>" ).text( item.nombre ) )
	      .appendTo( ul );
	};
	
	$("#agregar").click(function(){
		
		agregarLinea();
		if(otrosimptos==1){
			mostrarOtrosImp();
		}
	
	});
	
	$("#otrosimptos").click(function(){
		mostrarOtrosImp();
	});	
	
});