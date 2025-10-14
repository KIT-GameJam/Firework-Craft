class_name Flask 
extends TextureRect

@export var particles: FlaskParticles

const MAX_CORNERS = 12
const MAX_SIZE = 10

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
	flask_color += res.color_modifier
	flask_size = clampi(flask_size + res.size_modifier, 0, MAX_SIZE)
	flask_corners = clampi(flask_corners + res.corner_modifier, 0, MAX_CORNERS)

func _update_particle_effect():
	particles.set_flask_color(flask_color)
	particles.set_flask_size(flask_size)
	particles.set_flask_corners(flask_corners)
