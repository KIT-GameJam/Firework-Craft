extends Control

@export var shapeTollerance: int = 1
@export var colorTollerance: int = 1
@export var sizeTollerance: int = 1

@export var textDescription: String

@export var textures: Array[Texture2D]
@export var textFieldPos: Array[Vector2]
@export var textFieldSize: Array[Vector2]

var expected_product: RequestResource
var currentTexture: Texture2D

@onready var label: Label = $Label
@onready var textureRect: TextureRect = $"."


# Size     Pos
# 230, 65, 110, 155
# 265, 65, 80, 155


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

func _get_drag_data(_pos: Vector2) -> RequestResource:
	print("debug")
	# Use another resource as drag preview.
	var res = Label.new()
	res.text = "Test"
	# res.texture = currentTexture

	# Allows us to center the resource on the mouse
	var preview = Control.new()
	preview.add_child(res)
	res.position = -0.5 * res.size
	# Sets what the user will see they are dragging
	set_drag_preview(preview)
	# Return resource as drag data
	return expected_product;
