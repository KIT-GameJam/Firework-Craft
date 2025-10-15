extends TextureRect
class_name AbstractIngredient

@export var resourceData: FireworkResource
var active: bool = false
var dif: Vector2 = Vector2.ZERO
var origin: Vector2

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	tooltip_text = _generate_tooltip_text()

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if not active:
				origin = global_position
			dif = global_position - get_viewport().get_mouse_position()
			active = true
			Global.selected_res = self
			Global.ingredient_inhand = true
		else:
			active = false
			Global.ingredient_inhand = false
			global_position = origin
	elif event is InputEventMouseMotion and active:
		global_position = get_viewport().get_mouse_position() + dif

func _generate_tooltip_text() -> String:
	var s: String = ""
	s += str("Color Modifier: ", resourceData.color_modifier , "\n")
	s += str("Size Modifier: ", resourceData.size_modifier , "\n")
	s += str("Corner Modifier: ", resourceData.corner_modifier , "\n")
	return s
