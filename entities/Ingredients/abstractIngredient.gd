extends TextureRect
class_name AbstractIngredient

@export var resourceData: FireworkResource
var active: bool = false
var dif: Vector2 = Vector2.ZERO
var origin: Vector2

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if not active:
				origin = global_position
			dif = global_position - get_viewport().get_mouse_position()
			active = true
			Global.selected_res = self
			Global.selected = true
		else:
			active = false
			Global.selected = false
			global_position = origin
	elif event is InputEventMouseMotion and active:
		global_position = get_viewport().get_mouse_position() + dif
