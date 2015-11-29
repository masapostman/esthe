$(function(){
    $("#resets").click(function(){
        $("#search_store_code").val("");
    	$("#search_order_date_from").val("");
    	$("#search_order_date_to").val("");
    	$("#search_order_date_from" ).datepicker({
					maxDate: "+1m +1w"
				});
    	var maxDate = $("#search_order_date_from" ).datepicker( "option", "maxDate" );
    	$("#search_order_date_from" ).datepicker( "option", "maxDate", "+1m +1w" );

    	$("#search_order_date_to" ).datepicker({
					minDate: "+1m +1w"
				});
    	var minDate = $("#search_order_date_to" ).datepicker( "option", "minDate" );
    	$("#search_order_date_to" ).datepicker( "option", "minDate", "-1m -1w" );

    }) ;
});