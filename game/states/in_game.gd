extends GameState


@export var main_menu_game_state: GameState


func enter(p_previous_state):
	super.enter(p_previous_state)

	state_scene.set_state_node(self)


func change_to_main_menu_game_state():
	change_state(main_menu_game_state)
