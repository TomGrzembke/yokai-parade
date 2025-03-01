extends GameState


@export var main_menu_game_state: GameState
@export var quit_game_state: GameState


func enter(p_previous_state):
	super.enter(p_previous_state)

	state_scene.set_state_node(self)

	await parent.fade_out_music(1.0)


func change_to_main_menu_game_state():
	change_state(main_menu_game_state)


func change_to_quit_game_state():
	change_state(quit_game_state)


func play_game_music():
	parent.play_game_music()
