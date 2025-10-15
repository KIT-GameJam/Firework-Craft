class_name Flask 
extends TextureRect

signal request_complete(wait_time: int, satisfaction: int)

@onready var particles: FlaskParticles = $Particles
@onready var bg := $Background

var current_value := 0
var product_costs := 0
var flask_color := 1 # default: white
var flask_size := 1 # default: small
var flask_corners := 1 # default: circle
var ingredients_in_me := false
var requestHover: bool = false

func _gui_input(event):
	if event is InputEventMouse:
		if event.is_released() and ingredients_in_me:
			Sfx.play_sfx("water_splash")
			mix_res(Global.selected_res)
			ingredients_in_me = false
			Global.ingredient_inhand = false
			Global.selected_res.queue_free()
		elif event.is_released() and requestHover:
			Sfx.play_sfx("complete")
			handle_abgabe(Global.selectedRequest.expected_product)
			requestHover = false;
			Global.request_inhand = false
			Global.selectedRequest.queue_free()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		Sfx.play_sfx("small_splash")

func _mouse_entered() -> void:
	ingredients_in_me = Global.ingredient_inhand and not Global.selected_res == null
	if not ingredients_in_me:
		Global.selected_res = null
		
	requestHover = Global.request_inhand and not Global.selectedRequest == null
	if not requestHover:
		Global.selectedRequest = null
	
func _mouse_exited() -> void:
	ingredients_in_me = false
	requestHover = false

func calc_values() -> void:
	current_value = current_value + flask_color + flask_size + flask_corners
	
func handle_abgabe(expected_product: RequestResource) -> void:
	var shapeDiff: int = max(0, abs(flask_corners - expected_product.corners) - expected_product.cornersTollerance)
	var colorDiff: int = max(0, abs((flask_color - expected_product.color) % 12) - expected_product.colorTollerance) # TODO Funktion überprüfen
	var sizeDiff: int = max(0, abs(flask_size - expected_product.size) - expected_product.sizeTollerance)
	var total_diff = shapeDiff + colorDiff + sizeDiff
	
	var elapsed_time = roundi((Time.get_ticks_msec() - expected_product.start_time) / 1000.)
	var satisfaction = max(0, 10 - total_diff)
	
	request_complete.emit(elapsed_time, satisfaction)

func mix_res(res_abstr: AbstractIngredient) -> void:
	var res = res_abstr.resourceData
	flask_color = flask_color + res.color_modifier % Global.MAX_COLOR
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
