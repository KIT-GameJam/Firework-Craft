extends Control

const satisfaction_threshold := 50

var level_nr: int = 0
@onready var title : Label = $MarginContainer/VBoxContainer/Title
@onready var progress_bar : ProgressBar = $MarginContainer/VBoxContainer/ProgressBar
@onready var stats_list : ItemList = $MarginContainer/VBoxContainer/ItemList
@onready var wait_time_label: Label = $MarginContainer/VBoxContainer/AverageWaitTime
@onready var flowers : Label = $MarginContainer/VBoxContainer/MarginContainer/FlowerLabel
var total_satisfaction : int = 0
var average_wait_time: int = 0
var level_stats : Array[Level.CustomerStats] = []
signal select_level_1
signal show_loose_screen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	title.text = "Day " + str(level_nr)
	calc_total_satisfaction()
	set_stats_list()
	wait_time_label.text += str(average_wait_time, 's')
	flowers.text = str(Global.countedFlower)
	progress_bar.value = 0
	var tween = create_tween()
	tween.tween_property(progress_bar, "value", total_satisfaction, 2.0) # (Zielwert, Dauer)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	
func set_stats(stats_arr: Array[Level.CustomerStats], curr_level: int):
	level_stats = stats_arr
	level_nr = curr_level

func set_stats_list():
	for x in range(level_stats.size()):
		stats_list.add_item("Costumer " + str(x+1) + " with Satisfaction: " + str(level_stats.get(x).satisfaction * 10) + "%, Waittime: " +  str(level_stats.get(x).wait_time))

func calc_total_satisfaction():
	var curr_satisfaction: int = 0
	var curr_wait_time: float = 0
	for stat in level_stats:
		curr_satisfaction = curr_satisfaction + stat.satisfaction
		curr_wait_time = curr_wait_time + stat.wait_time
		print(curr_satisfaction)
		print(curr_wait_time)

	total_satisfaction = (curr_satisfaction / float(level_stats.size()*10)) * 100
	average_wait_time = curr_wait_time / float(level_stats.size())
	
	
	
func _on_button_pressed() -> void:
	if total_satisfaction < satisfaction_threshold:
		show_loose_screen.emit()
	else:
		select_level_1.emit()
	queue_free()
