extends Node

@export var color: Color = Color.WHITE
@export var size: int = 0
@export var corners: int = 0

@onready var particles := $CPUParticles2D
@onready var mesh := $MultiMesh

func _ready() -> void:
	set_corners(corners)
	set_color(color)
	set_size(size)

func set_size(size: int):
	var mesh_scale := 200 + size * 20
	var particle_scale = 10 + size * 2
	mesh.scale = Vector2(mesh_scale, mesh_scale)
	particles.lifetime = 2 + .2 * size
	particles.scale_amount_min = particle_scale - 2
	particles.scale_amount_max = particle_scale + 2

func set_corners(num_corners: int):
	mesh.set_corners(corners)

func set_color(color: Color):
	particles.color = color
	mesh.set_color(color)
