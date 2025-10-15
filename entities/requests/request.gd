extends TextureRect
class_name Request

@export var textDescription: String

@export var textures: Array[Texture2D]
@export var textFieldPos: Array[Vector2]
@export var textFieldSize: Array[Vector2]

var expected_product: RequestResource
var origin: Vector2

var diff: Vector2 = Vector2.ZERO
var active: bool = false

@onready var label: Label = $Label
@onready var textureRect: TextureRect = $"."
@onready var particles: FlaskParticles = $MarginContainer/Particles

func _ready() -> void:
	# label.text = textDescription # ???
	var index: int = randi_range(0, 2)
	textureRect.texture = textures[index]
	
	var r_size = randi_range(1, Global.MAX_SIZE)
	var r_color = randi_range(1, Global.MAX_COLOR)
	var r_corners = randi_range(1, Global.MAX_CORNERS)
	
	particles.set_flask_size(r_size)
	particles.set_flask_color(Global.colors[r_color])
	particles.set_flask_corners(r_corners)
	
	expected_product = RequestResource.new(r_size, r_color, r_corners)
	# currentTexture = textures[index]
	# label.position = textFieldPos[index]
	# label.size = textFieldSize[index]
	
	

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
