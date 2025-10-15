extends Control

var level_nr: int = 0
@onready var title : Label = $MarginContainer/VBoxContainer/Title
@onready var progress_bar : ProgressBar = $MarginContainer/VBoxContainer/ProgressBar
@onready var stats_list : ItemList = $MarginContainer/VBoxContainer/ItemList
var total_satisfaction : int = 0
var level_stats : Array[Level.CustomerStats] = []
signal select_level_1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	title.text = "Day " + str(level_nr)
	calc_total_satisfaction()
	set_stats_list()
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
		stats_list.add_item("Costumer " + str(x+1) + " with Satisfaction: " + str(level_stats.get(x).satisfaction) + ", Waittime: " +  str(level_stats.get(x).wait_time))

func calc_total_satisfaction():
	var curr_satisfaction = 0
	for i in range(level_stats.size()):
		curr_satisfaction = curr_satisfaction + level_stats.get(i).satisfaction
	total_satisfaction = curr_satisfaction	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _on_button_pressed() -> void:
	select_level_1.emit()
	queue_free()
