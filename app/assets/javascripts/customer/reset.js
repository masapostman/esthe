$(function(){
    $("#reset").click(function(){
        $('input:text').val("");
        $("#search_order_date_from").val("");
        $("#search_order_date_to").val("");
        $("#search_order_date_from" ).datepicker({
                    maxDate: "+1m +1w"
                });

    }) ;
});