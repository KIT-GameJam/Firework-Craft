extends Node

signal end

var level_scene: PackedScene = load("res://levels/main_level.tscn")
var stats_scene: PackedScene = load("res://ui/screens/day-over-screen/day_over_screen.tscn")
var level_number = 0

func _ready() -> void:
	_next_level()

func _next_level() -> void:
	level_number += 1
	_make_level(level_number)

func _make_level(nr: int) -> void:
	var level: Level = level_scene.instantiate()
	level.day_over.connect(_show_stats)
	add_child(level)

func _show_stats() -> void :
	var curr_stats = stats_scene.instantiate()
	curr_stats.select_level_1.connect(_next_level)
	add_child(curr_stats)
