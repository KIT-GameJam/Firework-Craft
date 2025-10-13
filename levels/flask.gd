extends Area2D

var current_value := 0
var product_costs := 0
var flask_color := 0 # default: white
var flask_form := 0 # default: small
var flask_corners := 0 # default: circle

func calc_values() -> void:
	current_value = current_value + flask_color + flask_form + flask_corners
	
#func adapt_flask_values() -> void:
	
