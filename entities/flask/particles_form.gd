extends Polygon2D

@export var base_radius := 128.0
var radius := base_radius
var segments := 3

func set_size(size: int):
	radius = base_radius + size * 10
	_redraw()

func set_corners(corners: int):
	segments = 3 + corners
	_redraw()

func set_shader_color(new_color: Color):
	var mat: ShaderMaterial = material
	mat.set_shader_parameter("color_modulate", Vector3(new_color.r, new_color.g, new_color.b))

func _redraw():
	var points = []
	for i in range(segments):
		var angle = i * TAU / segments
		var x = cos(angle)
		var y = sin(angle)
		points.append(Vector2(x, y) * radius)
		# generate UVs from normalized circle coordinates
	polygon = points
