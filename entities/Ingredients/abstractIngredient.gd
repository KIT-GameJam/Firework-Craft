extends TextureRect
class_name AbstractIngredient

@export var resourceData: FireworkResource
var active: bool = false
var dif: Vector2 = Vector2.ZERO

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dif = global_position - get_viewport().get_mouse_position()
			active = true
			
		else:
			active = false

	elif event is InputEventMouseMotion and active:
		global_position = get_viewport().get_mouse_position() + dif

func _get_drag_data(_pos: Vector2) -> FireworkResource:
	var res := TextureRect.new()
	res.texture = texture

	var preview := Control.new()
	preview.add_child(res)
	res.position = -0.5 * res.size
	set_drag_preview(preview)

	return resourceData
