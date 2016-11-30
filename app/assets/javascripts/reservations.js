var numberWithCommas = function(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
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

function available(date) {
	var array = JSON.parse($("#all-bookings").text())
	ymd = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
	if ($.inArray(ymd, array) == -1) {
		return [true, "", "Available"]
	} else {
		return [false, "", "Booked"]
	}
}

$(document).ready(function() {
	var $start 	= $('#available-dates #start').text()
	var $end 	= $('#available-dates #end').text()
	$('#check-in').datepicker({
		onSelect: function(dateText, inst) {
			setTimeout(function() {
				var $price = parseFloat($('#price-per-night').text());
				var data_date_in 	= $('.datepicker #check-in').text();
				var data_date_out 	= $('.datepicker #check-out').text();
				var numDays = daysBetween(data_date_in, data_date_out).length;
				var totalCost = $price * numDays;
				document.getElementById("total-cost").innerHTML = numberWithCommas(totalCost);
				document.getElementById("total-cost-submit").setAttribute("value", totalCost);
			}, 1000);
		},
		format: "yyyy-mm-dd",
		startDate: $start,
		endDate: $end,
	    beforeShowDay: available
	});
	
	$('#check-out').datepicker({
		onSelect: function(dateText, inst) {
			setTimeout(function() {
				var $price = parseFloat($('#price-per-night').text());
				var data_date_in 	= $('.datepicker #check-in').text();
				var data_date_out 	= $('.datepicker #check-out').text();
				var numDays = daysBetween(data_date_in, data_date_out).length;
				var totalCost = $price * numDays;
				document.getElementById("total-cost").innerHTML = numberWithCommas(totalCost);
				document.getElementById("total-cost-submit").setAttribute("value", totalCost);
			}, 1000);
		},
		format: "yyyy-mm-dd",
		startDate: $start,
		endDate: $end,
	    beforeShowDay: available
	});
});

