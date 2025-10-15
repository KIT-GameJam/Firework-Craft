extends Control

var level_nr: int
@onready var title : Label = $VBoxContainer/Title
var total_satisfaction : int = 0
var level_stats : Array[Level.CustomerStats] = []
signal restart
signal go_main_menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	title.text = "Day " + str(level_nr)

func _on_restart_pressed() -> void:
	restart.emit()
	queue_free()

func _on_return_pressed() -> void:
	go_main_menu.emit()
	queue_free()
