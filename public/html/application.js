// JavaScript Document

$(document).ready(function() {
	var cities = ["Nashville, TN", "Denver, CO", "Dallas, TX"];
	
	$("#homeInput").autocomplete({
		source: cities
	});
});