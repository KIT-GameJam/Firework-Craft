extends Control

@export var shapeTollerance: int = 1
@export var colorTollerance: int = 1
@export var sizeTollerance: int = 1

@export var textures: Array[Texture2D]

var expected_product: FireworkResource
var textDescription: String

@onready var label: Label = $PanelContainer/MarginContainer/Label
@onready var textureRect: TextureRect = $PanelContainer/MarginContainer/TextureRect

func _ready() -> void:
	label.text = textDescription # Oder so?
	textureRect.texture = textures.pick_random()
	

# farbe array 
# dict für farbwerte 
# farben mischen wird in der mitte geschaut
# farb tolleranz auf distanz im array zum farbwert


func is_as_requested(final_product: FireworkResource) -> bool:
	var shapeDiff: int = abs(final_product.corner_modifier - expected_product.color_modifier)
	var colorDiff: int = abs((final_product.color_modifier - expected_product.color_modifier) % 12) # TODO Funktion überprüfen
	var sizeDiff: int = abs(final_product.size_modifier - expected_product.color_modifier)
	
	return shapeDiff <= shapeTollerance && colorDiff <= colorTollerance && sizeDiff <= sizeTollerance
