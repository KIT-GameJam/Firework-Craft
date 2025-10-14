class_name FlaskParticles
extends Control

@export var flask_color: Color = Color.WHITE
@export var flask_size: int = 0
@export var flask_corners: int = 0

@onready var particles := $CPUParticles2D
@onready var form := $Form

func _ready() -> void:
	set_flask_color(flask_color)
	set_flask_size(flask_size)
	set_flask_corners(flask_corners)

func set_flask_size(size: int):
	var particle_scale = 10 + size * 2
	form.set_size(size)
	particles.lifetime = 2 + .2 * size
	particles.scale_amount_min = particle_scale - 2
	particles.scale_amount_max = particle_scale + 2

func set_flask_corners(num_corners: int):
	form.set_corners(num_corners)

func set_flask_color(color: Color):
	particles.color = color
	form.set_color(color)
