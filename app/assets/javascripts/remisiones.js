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

	function clean(){
    	$("#concepto").val("");
		$("#punit").val("");
		$("#unidad").val("");
		$("#cantidad").val("");
		$("#concepto").focus();
	}

	var lines = 0;

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
			$("#unidad").val(ui.item.unidad.nombre);
			$("#cantidad").focus();
		}
	});
	
	$("#agregar").click(function(){
		var line = '<tr><td><div class="btn btn-danger" onclick="$(this).parent().parent().remove();"><span class="glyphicon glyphicon-remove"></span></button></td><td>'+$("#concepto").val()+'</td><td>'+$("#punit").val()+'</td><td>'+$("#cantidad").val()+'</td><td>'+$("#unidad").val()+'</td><td><p class="lead text-right">$1,000.00</strong></td></tr>';
		$("#conceptos").append(line);
		lines++;
		clean();
	});
	
});