class_name Level
extends Control

signal day_over(info: Array[CustomerStats])

# Taglänge in Sekunden
@export var daylength: float = 10.0
# Geduld von Kunden [0,1]
@export var patience: float = 0.5
@export var requests_amount: int = 3

var customerdata: Array[CustomerStats] = []

@export var ingredient_scenes: Array[PackedScene]
@onready var ingredient_table: Node = $VBoxContainer/HBoxContainer2/IngredientTable

var request_scene: PackedScene = load("res://entities/requests/request.tscn")

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	for i in range(9):
		_add_ingredient()
	%Timer.start(daylength)
	_add_request()
	

func _process(_delta: float) -> void:
	%TimerLabel.text = str(snapped(%Timer.time_left,1))

func _add_request() -> void:
	if $VBoxContainer/HBoxContainer/Requests.get_children().size() < 5:
		var request: Request = request_scene.instantiate()
		request.tree_exited.connect(_request_complete)
		$VBoxContainer/HBoxContainer/Requests.add_child.call_deferred(request)
		get_tree().create_timer(max(daylength/requests_amount,0.5)).timeout.connect(_add_request)
	else: # costumers can not be satisfied at all, just leaves immediately
		var stat = CustomerStats.new()
		stat.satisfaction = 0
		stat.wait_time = 100
		customerdata.append(stat)

func _request_complete():
	var stat = CustomerStats.new()
	stat.satisfaction = 10
	stat.wait_time = 0
	customerdata.append(stat)
	

func _add_ingredient() -> void:
	var ingredient: AbstractIngredient = ingredient_scenes.pick_random().instantiate()
	ingredient.tree_exited.connect(_add_ingredient)
	ingredient_table.add_child.call_deferred(ingredient)

func _day_over() -> void:
	day_over.emit(customerdata)
	queue_free()

class CustomerStats:
	var satisfaction: int
	var wait_time: float
