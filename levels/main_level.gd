class_name Level
extends Control

signal day_over(info: Array[CustomerStats])

# Taglänge in Sekunden
@export var daylength: float = 10.0
# Geduld von Kunden [0,1]
@export var patience: float = 0.5
@export var requests_amount: int = 3

var customerdata: Array[CustomerStats] = []
var nb_flowers: int = 0

@export var ingredient_scenes: Array[PackedScene]
@onready var ingredient_table: Node = $VBoxContainer/HBoxContainer2/IngredientTable
@onready var request_container: HBoxContainer = $VBoxContainer/HBoxContainer/Requests

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
	if request_container.get_children().size() < 5:
		var request: Request = request_scene.instantiate()
		#request.tree_exited.connect(_request_complete)
		request_container.add_child.call_deferred(request)
		get_tree().create_timer(max(daylength/requests_amount,0.5)).timeout.connect(_add_request)
	else: # costumers can not be satisfied at all, just leaves immediately
		add_new_stat(100, 0)

func _add_ingredient() -> void:
	var ingredient: AbstractIngredient = ingredient_scenes.pick_random().instantiate()
	ingredient.tree_exited.connect(_add_ingredient)
	ingredient_table.add_child.call_deferred(ingredient)

func _day_over() -> void:
	# All remaining customers arent sent away
	for child: Request in request_container.get_children():
		add_new_stat(100, 0)
		
	day_over.emit(customerdata)
	queue_free()

class CustomerStats:
	var satisfaction: int
	var wait_time: float

func _on_flask_request_complete(wait_time: int, satisfaction: int) -> void:
	add_new_stat(wait_time, satisfaction)
	
func add_new_stat(wait_time: int, satisfaction: int):
	var stat = CustomerStats.new()
	stat.wait_time = wait_time
	stat.satisfaction = satisfaction
	customerdata.append(stat)
