var numberWithCommas = function(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;

    return [year, month, day].join('-');
}

var daysBetween = function(date_in, date_out) {
	var d_in 	= new Date(date_in);
	var d_out 	= new Date(date_out);
	var days 	= [];
	while (d_in <= d_out) {
		days.push(d_in);
		d_in.setDate(d_in.getDate() + 1);
	};
	return days;
}

// var data_date_in 	= $('#check-in').val();
// var data_date_out 	= $('#check-out').val();

$(document).ready(function() {
	var $start 	= $('#available-dates #start').text()
	var $end 	= $('#available-dates #end').text()
	var array 	= JSON.parse($("#all-bookings").text())
	var $price = parseFloat($('#price-per-night').text());
	
	var available = function(date) {
		formattedDate = formatDate(date);
		return $.inArray(formattedDate, array) == -1;
	}

	$('#check-in').datepicker({
		onSelect: function(dateText) {	
			var data_date_in 	= dateText;
		},
		autoclose: true,
		format: "yyyy-mm-dd",
		startDate: $start,
		endDate: $end,
	    beforeShowDay: available
	});
	
	$('#check-out').datepicker({
		onSelect: function(dateText) {	
			var data_date_out 	= dateText;
			var numDays = daysBetween(data_date_in, data_date_out).length;
			var totalCost = $price * numDays;
			$("#total-cost").text(numberWithCommas(totalCost));
			$("#total-cost-submit").val(totalCost);
		},
		autoclose: true,
		format: "yyyy-mm-dd",
		startDate: $start,
		endDate: $end,
	    beforeShowDay: available
	});
});
