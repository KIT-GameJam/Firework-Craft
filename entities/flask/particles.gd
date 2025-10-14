extends Node

@export var color: Color = Color.WHITE
@export var size: int = 0
@export var corners: int = 0

@onready var particles := $CPUParticles2D
@onready var form := $Form

func _ready() -> void:
	set_corners(corners)
	set_color(color)
	set_size(size)

func set_size(size: int):
	var particle_scale = 10 + size * 2
	form.set_size(size)
	particles.lifetime = 2 + .2 * size
	particles.scale_amount_min = particle_scale - 2
	particles.scale_amount_max = particle_scale + 2

func set_corners(num_corners: int):
	form.set_corners(corners)

func set_color(color: Color):
	particles.color = color
	form.set_color(color)
