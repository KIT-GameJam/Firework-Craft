extends Control

@export var shapeTollerance: int = 1
@export var colorTollerance: int = 1
@export var sizeTollerance: int = 1

@export var textDescription: String

@export var textures: Array[Texture2D]
@export var textFieldPos: Array[Vector2]
@export var textFieldSize: Array[Vector2]

var expected_product: RequestResource
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

func is_as_requested(final_product: FireworkResource) -> bool:
	var shapeDiff: int = abs(final_product.corner_modifier - expected_product.corners)
	var colorDiff: int = abs((final_product.color_modifier - expected_product.color) % 12) # TODO Funktion überprüfen
	var sizeDiff: int = abs(final_product.size_modifier - expected_product.size)
	
	return shapeDiff <= shapeTollerance && colorDiff <= colorTollerance && sizeDiff <= sizeTollerance

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if not active:
				origin = global_position
			diff = global_position - get_viewport().get_mouse_position()
			active = true
		else:
			global_position = origin
			active = false

	elif event is InputEventMouseMotion and active:
		global_position = get_viewport().get_mouse_position() + diff
