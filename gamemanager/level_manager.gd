extends Node

signal end

var level_scene: PackedScene = load("res://levels/main_level.tscn")
var stats_scene: PackedScene = load("res://ui/screens/day-over-screen/day_over_screen.tscn")
var level_number = 0

var level_times: Array[float] = [30, 25, 25, 22, 21, 20, 20, 20, 20, 15]
var level_request_amounts: Array[int] = [2, 3, 4, 4, 5, 6, 7, 8, 9, 10]

func _ready() -> void:
	_next_level()

func _next_level() -> void:
	level_number += 1
	_make_level(level_number)

func _make_level(nr: int) -> void:
	var level: Level = level_scene.instantiate()
	level.day_over.connect(_show_stats)
	level.requests_amount = level_request_amounts[min(nr,10)]
	level.daylength = level_times[min(nr,10)]
	add_child(level)

func _show_stats(_v: Array[Level.CustomerStats]) -> void :
	Sfx.play_sfx("win")
	var curr_stats = stats_scene.instantiate()
	curr_stats.set_stats(_v, level_number)
	curr_stats.select_level_1.connect(_next_level)
	add_child(curr_stats)
