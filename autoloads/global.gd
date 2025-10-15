extends Node

var game_manager : GameManager = null
var selected_res : AbstractIngredient = null
var selectedRequest: Request = null

const MAX_CORNERS = 12
const MAX_SIZE = 6
const MAX_COLOR := 12
const colors = {
	1: Color('f4e601'), # yellow
	2: Color('f9c30b'), # yellow_orange
	3: Color('f28e1e'), # orange
	4: Color('eb6120'), # orange_red
	5: Color('e12323'), # red
	6: Color('c1027b'), # purple_red
	7: Color('6d398b'), # purple
	8: Color('444d98'), # purple_blue
	9: Color('2b70b1'), # blue
	10: Color('0797bc'), # light_blue
	11: Color('018e5a'), # green
	12: Color('8dbb27') # olive
}

var ingredient_inhand : bool = false
var request_inhand : bool = false

func set_game_manager(p_game_manager: GameManager):
	game_manager = p_game_manager
