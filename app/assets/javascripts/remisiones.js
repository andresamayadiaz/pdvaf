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
$(function() {
	
	var lines = 0;
	
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
	
	function calcImporte(){
		var cantidad = parseFloat($("#cantidad").val());
		var punit = parseFloat($("#punit").val());
		var importe = (cantidad * punit);
		$("#importe").html("$"+formatMoney(importe,2,',', '.'));
	}
	
	function clean(){
    	$("#concepto").val("");
		$("#punit").val("");
		$("#unidad").val("");
		$("#cantidad").val("");
		$("#importe").html("$0.00");
		$("#concepto").focus();
	}
	
	$("#cantidad").keyup(calcImporte);
	$("#punit").keyup(calcImporte);
	
	$.ui.autocomplete.prototype._renderItem = function (ul, item) {
		console.log(item);
	    return $( "<li>" )
	      .attr( "data-value", item.nombre )
	      .append( $( "<a>" ).text( item.nombre ) )
	      .appendTo( ul );
	};
	
	$( "#concepto" ).autocomplete({
	  source: "/productos.json",
	  minLength: 3,
	  select: function( event, ui ) {
			event.preventDefault();
			this.value = ui.item.nombre;
	    	$("#cantidad").val("1");
			$("#punit").val(ui.item.precio);
			$("#unidad").val(ui.item.unidad.nombre);
			$("#cantidad").focus();
			calcImporte();
		}
	});
	
	$("#agregar").click(function(){
		var line = '<tr><td><div class="btn btn-danger" onclick="$(this).parent().parent().remove();"><span class="glyphicon glyphicon-remove"></span></button></td><td>'+$("#concepto").val()+'</td><td>'+$("#punit").val()+'</td><td>'+$("#cantidad").val()+'</td><td>'+$("#unidad").val()+'</td><td><p class="lead text-right">$1,000.00</strong></td></tr>';
		$("#conceptos").append(line);
		lines++;
		clean();
	});
	
});