class_name Level
extends Control

signal day_over()

# Taglänge in Sekunden
@export var daylength: float = 10.0
# Gedult von Kunden [0,1]
@export var patience: float = 0.5

var customerdata: Array[CustomerStats] = []

func _ready() -> void:
	print("Start Level")
	%Timer.start(daylength)

func _process(_delta: float) -> void:
	%TimerLabel.text = str(snapped(%Timer.time_left,0.01))

func _day_over() -> void:
	day_over.emit()

class CustomerStats:
	var satisfaction: float
	var wait_time: float
