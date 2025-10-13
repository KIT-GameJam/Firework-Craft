extends TextureRect

var current_value := 0
var product_costs := 0
var flask_color := 0 # default: white
var flask_size := 0 # default: small
var flask_corners := 0 # default: circle

func calc_values() -> void:
	current_value = current_value + flask_color + flask_size + flask_corners
	
# Returns a boolean by examining the data being dragged to see if it's valid
# to drop here
func _can_drop_data(_pos, data):
	return typeof(data) == TYPE_OBJECT and data is FireworkResource

# Takes the data being dragged and processes it
func _drop_data(_pos: Vector2, data: Variant):
	if data is not FireworkResource:
		return
		
	var res: FireworkResource = data
	
	flask_color = res.color_modifier
	flask_size = res.size_modifier
	flask_corners = res.corner_modifier
