extends Control

const shapeTollerance: int = 1
const colorTollerance: int = 1
const sizeTollerance: int = 1

var expected_product: FireworkResource
var textDescription: String

@onready var label: Label = $PanelContainer/MarginContainer/Label

func _ready() -> void:
	label.text = textDescription # Oder so?

# farbe array 
# dict für farbwerte 
# farben mischen wird in der mitte geschaut
# farb tolleranz auf distanz im array zum farbwert


func is_as_requested(final_product: FireworkResource) -> bool:
	var shapeDiff: int = abs(final_product.corner_modifier - expected_product.color_modifier)
	var colorDiff: int = abs((final_product.color_modifier - expected_product.color_modifier) % 12) # TODO Funktion überprüfen
	var sizeDiff: int = abs(final_product.size_modifier - expected_product.color_modifier)
	
	return shapeDiff <= shapeTollerance && colorDiff <= colorTollerance && sizeDiff <= sizeTollerance
