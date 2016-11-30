$('.reservation .datepicker').datepicker({
    beforeShowDay: function(date){
    	var array = JSON.parse($("#all-bookings").text())
        var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
        return [ array.indexOf(string) == -1 ]
    }
});
