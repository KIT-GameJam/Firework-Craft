extends Node

var game_manager : GameManager = null
var selected_res : AbstractIngredient = null
var selectedRequest: Request = null

const MAX_CORNERS : int = 6
const MAX_SIZE : int = 3
const MAX_COLOR : int = 6
const colors = {
	1: Color('f4e601'), # yellow
	2: Color('f28e1e'), # orange
	3: Color('e12323'), # red
	4: Color('6d398b'), # purple
	5: Color('2b70b1'), # blue
	6: Color('018e5a'), # green
}

var ingredient_inhand : bool = false
var request_inhand : bool = false

func set_game_manager(p_game_manager: GameManager):
	game_manager = p_game_manager
