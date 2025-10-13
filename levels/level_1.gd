extends Area2D

var current_value := 0
var ressource_costs := 0
#var curr_ingredient: FireworkResource

func calc_product_val() -> void:
	var calc_val := current_value
	
	#calculation of resource values
	current_value = calc_val
	
#get drop data	
	
func on_reset() -> void:
	current_value = 0
