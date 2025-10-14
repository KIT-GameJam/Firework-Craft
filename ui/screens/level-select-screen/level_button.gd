class_name LevelButton
extends Button

var level_nr: int
signal select_level()

func _ready() -> void:
	text = str(level_nr)

func _on_pressed() -> void:
	select_level.emit()
	queue_free()
