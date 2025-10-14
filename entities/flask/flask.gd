class_name Flask 
extends TextureRect

@onready var particles: FlaskParticles = $Particles
@onready var bg := $Background

var current_value := 0
var product_costs := 0
var flask_color := 1 # default: white
var flask_size := 1 # default: small
var flask_corners := 1 # default: circle
var ingredients_in_me := false
var requestHover: bool = false

var final_product: FireworkResource

func _gui_input(event):
	if event is InputEventMouse:
		if event.is_released() and ingredients_in_me:
			mix_res(Global.selected_res)
			ingredients_in_me = false
			Global.selected = false
			Global.selected_res.queue_free()
		if event.is_released() and requestHover:
			var total_diff: int = is_as_requested(Global.selectedRequest.expected_product) # TODO Hier ist die final diff
			print(total_diff)
			requestHover = false;
			Global.selectedRequest.queue_free()

func _mouse_entered() -> void:
	ingredients_in_me = Global.selected and not Global.selected_res == null
	if not ingredients_in_me:
		Global.selected_res = null
		
	requestHover = Global.selected and not Global.selectedRequest == null
	if not requestHover:
		Global.selectedRequest = null
	
func _mouse_exited() -> void:
	ingredients_in_me = false
	requestHover = false

func calc_values() -> void:
	current_value = current_value + flask_color + flask_size + flask_corners
	
func is_as_requested(expected_product: RequestResource) -> int:
	# var shapeDiff: int = abs(final_product.corner_modifier - expected_product.corners)
	# var colorDiff: int = abs((final_product.color_modifier - expected_product.color) % 12) # TODO Funktion überprüfen
	# var sizeDiff: int = abs(final_product.size_modifier - expected_product.size)
	
	# return shapeDiff + colorDiff + sizeDiff
	return 0

func mix_res(res_abstr: AbstractIngredient) -> void:
	var res = res_abstr.resourceData
	flask_color = clampi(flask_color + res.color_modifier , 1, Global.MAX_COLOR)
	flask_size = clampi(flask_size + res.size_modifier, 1, Global.MAX_SIZE)
	flask_corners = clampi(flask_corners + res.corner_modifier, 1, Global.MAX_CORNERS)
	_update_particle_effect()

func reset():
	flask_color = 1
	flask_size = 1
	flask_corners = 1
	_update_particle_effect()

func _update_particle_effect():
	if is_instance_valid(particles):
		particles.set_flask_color(Global.colors[flask_color])
		particles.set_flask_size(flask_size)
		particles.set_flask_corners(flask_corners)
