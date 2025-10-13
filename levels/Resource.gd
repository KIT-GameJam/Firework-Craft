extends Resource
class_name FireworkResource

@export var size_modifier: int
@export var color_modifier: Color
@export var corner_modifier: int

func _get_drag_data(_pos):
	# Use another resource as drag preview.
	var res_vals = Resource.new()
	res_vals.size_modifier = size_modifier
	res_vals.color_modifier = color_modifier
	res_vals.corner_modifier = corner_modifier

	# Allows us to center the resource on the mouse
	var preview = Control.new()
	preview.add_child(res_vals)
	res_vals.position = -0.5 * res_vals.size
	# Sets what the user will see they are dragging
	set_drag_preview(preview)
	# Return resource as drag data
	return res_vals
