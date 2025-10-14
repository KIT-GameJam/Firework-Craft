extends Control
class_name Request

@export var textDescription: String

@export var textures: Array[Texture2D]
@export var textFieldPos: Array[Vector2]
@export var textFieldSize: Array[Vector2]

var expected_product: RequestResource = RequestResource.new()
var origin: Vector2

var currentTexture: Texture2D
var diff: Vector2 = Vector2.ZERO
var active: bool = false

@onready var label: Label = $Label
@onready var textureRect: TextureRect = $"."

func _ready() -> void:
	label.text = textDescription # ???
	var index: int = randi_range(0, 2)
	textureRect.texture = textures[index]
	currentTexture = textures[index]
	label.position = textFieldPos[index]
	label.size = textFieldSize[index]

# farbe array 
# dict für farbwerte 
# farben mischen wird in der mitte geschaut
# farb tolleranz auf distanz im array zum farbwert

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if not active:
				origin = global_position
			diff = global_position - get_viewport().get_mouse_position()
			active = true
			Global.selectedRequest = self
			Global.selected = true
		else:
			global_position = origin
			active = false
			Global.selected = false

	elif event is InputEventMouseMotion and active:
		global_position = get_viewport().get_mouse_position() + diff
