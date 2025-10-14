class_name Flask 
extends TextureRect

const MAX_CORNERS = 12
const MAX_SIZE = 10

@onready var particles: FlaskParticles = $Particles
@onready var bg := $Background

var current_value := 0
var product_costs := 0
var flask_color := 1 # default: white
var flask_size := 0 # default: small
var flask_corners := 0 # default: circle
var ingredients_in_me := false
var MAX_COLOR = Global.colors.size()

func _gui_input(event):
	if event is InputEventMouse:
		print("input event")
		print(event.is_released())
		print(ingredients_in_me)
		if event.is_released() and ingredients_in_me:
			print(3)
			mix_res(Global.selected_res)
			print("consumed")
			ingredients_in_me = false;
			Global.selected_res.queue_free()

func _mouse_entered() -> void:
	print("entered")
	print(Global.selected_res)
	ingredients_in_me = Global.selected_res != null
	
func _mouse_exited() -> void:
	print("exited")
	ingredients_in_me = false

func calc_values() -> void:
	current_value = current_value + flask_color + flask_size + flask_corners

func mix_res(res_abstr: AbstractIngredient) -> void:
	print(res_abstr)
	var res = res_abstr.resourceData
	flask_color += clampi(res.color_modifier, 1, MAX_COLOR)
	flask_size = clampi(flask_size + res.size_modifier, 0, MAX_SIZE)
	flask_corners = clampi(flask_corners + res.corner_modifier, 0, MAX_CORNERS)
	_update_particle_effect()

func _update_particle_effect():
	if is_instance_valid(particles):
		particles.set_flask_color(Global.colors[flask_color])
		particles.set_flask_size(flask_size)
		particles.set_flask_corners(flask_corners)
