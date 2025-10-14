extends TextureRect
class_name AbstractIngredient

@export var resourceData: FireworkResource

func _get_drag_data(_pos: Vector2) -> FireworkResource:
	# Use another resource as drag preview.
	var res = TextureRect.new()
	res.texture = texture

	# Allows us to center the resource on the mouse
	var preview = Control.new()
	preview.add_child(res)
	res.position = -0.5 * res.size
	# Sets what the user will see they are dragging
	set_drag_preview(preview)
	# Return resource as drag data
	return resourceData;
	
func mouse_entered() -> void:
	print("grab")
	
