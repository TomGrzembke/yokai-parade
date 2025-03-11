extends LevelState


func enter(_p_previous_state):
	super.enter(_p_previous_state)

	context.change_to_main_menu_game_state()
