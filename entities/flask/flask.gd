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
var ingredients_in_me := false

func _gui_input(event):
	if event is InputEventMouse:
		if event.is_released() and ingredients_in_me:
			mix_res(Global.selected_res)
			ingredients_in_me = false
			Global.selected = false
			Global.selected_res.queue_free()

func _mouse_entered() -> void:
	ingredients_in_me = Global.selected and not Global.selected_res == null
	if not ingredients_in_me:
		Global.selected_res = null
	
func _mouse_exited() -> void:
	ingredients_in_me = false

func calc_values() -> void:
	current_value = current_value + flask_color + flask_size + flask_corners

func mix_res(res_abstr: AbstractIngredient) -> void:
	var res = res_abstr.resourceData
	flask_color += res.color_modifier
	flask_size = clampi(flask_size + res.size_modifier, 0, MAX_SIZE)
	flask_corners = clampi(flask_corners + res.corner_modifier, 0, MAX_CORNERS)
	_update_particle_effect()

func _update_particle_effect():
	if is_instance_valid(particles):
		particles.set_flask_color(flask_color)
		particles.set_flask_size(flask_size)
		particles.set_flask_corners(flask_corners)
