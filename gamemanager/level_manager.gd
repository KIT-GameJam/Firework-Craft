extends Node

signal end

var level_scene: PackedScene = load("res://levels/main_level.tscn")
var level_number = 0

func _ready() -> void:
	_next_level()

func _next_level() -> void:
	level_number += 1
	_make_level(level_number)

func _make_level(_nr: int) -> void:
	var level: Level = level_scene.instantiate()
	level.day_over.connect(_next_level)
	add_child(level)
	
