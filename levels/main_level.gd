class_name Level
extends Control

signal day_over()

# Taglänge in Sekunden
@export var daylength: float = 10.0
# Geduld von Kunden [0,1]
@export var patience: float = 0.5

var customerdata: Array[CustomerStats] = []

@export var ingredient_scenes: Array[PackedScene]
@onready var ingredient_table: Node = $VBoxContainer/HBoxContainer2/IngredientTable
func _ready() -> void:
	print("Start Level")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	for i in range(9):
		_add_ingredient()
	%Timer.start(daylength)
	

func _process(_delta: float) -> void:
	%TimerLabel.text = str(snapped(%Timer.time_left,1))

func _add_ingredient() -> void:
	var ingredient: AbstractIngredient = ingredient_scenes.pick_random().instantiate()
	ingredient.tree_exited.connect(_add_ingredient)
	ingredient_table.add_child.call_deferred(ingredient)
	print("add ", ingredient.get_class())

func _day_over() -> void:
	day_over.emit()
	queue_free()

class CustomerStats:
	var satisfaction: float
	var wait_time: float
