extends Resource
class_name RequestResource

const cornersTollerance: int = 0
const colorTollerance: int = 0
const sizeTollerance: int = 0

var size: int
var color: int # 0-11 (12 Verschiedene Farben)
var corners: int
var start_time: int

func _init(r_size: int, r_color: int, r_corners: int, r_start_time: int) -> void:
	size = r_size
	color = r_color
	corners = r_corners
	start_time = r_start_time
