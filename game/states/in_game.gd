extends GameState


@export var main_menu_game_state: GameState


func enter(p_previous_state):
	super.enter(p_previous_state)
	current_scene.set_main_menu_game_state(main_menu_game_state)

	current_scene.game_state_scene_finished.connect(change_state)
