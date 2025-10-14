extends Node

var game_manager : GameManager = null
var selected_res : AbstractIngredient = null
var selectedReq: Request = null

func set_game_manager(p_game_manager: GameManager):
	game_manager = p_game_manager
