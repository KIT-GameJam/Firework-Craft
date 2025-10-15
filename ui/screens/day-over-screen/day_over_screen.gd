extends Control

var level_nr: int
@onready var title : Label = $VBoxContainer/Title
@onready var progress_bar : ProgressBar = $VBoxContainer/ProgressBar
var total_satisfaction : int = 75 # TODO: set this
var level_stats : Array[Level.CustomerStats] = []
signal select_level_1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	title.text = "Day " + str(level_nr)
	calc_total_satisfaction()
	progress_bar.value = 0
	var tween = create_tween()
	tween.tween_property(progress_bar, "value", total_satisfaction, 2.0) # (Zielwert, Dauer)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	
func set_stats(stats_arr: Array[Level.CustomerStats], curr_level: int):
	level_stats = stats_arr
	level_nr = curr_level

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
