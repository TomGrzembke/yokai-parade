extends LevelState


@export var return_to_main_menu_level_state: LevelState
@export var options_in_game_level_state: LevelState
@export var reset_to_checkpoint_level_state: LevelState
@export var reset_level_state: LevelState


func enter(p_previous_state):
	super.enter(p_previous_state)

	parent.set_game_paused(true)

	current_scene.set_previous_level_state(previous_state)
	current_scene.set_options_in_game_level_state(options_in_game_level_state)
	current_scene.set_return_to_main_menu_level_state(return_to_main_menu_level_state)
	current_scene.set_reset_checkpoint_level_state(reset_to_checkpoint_level_state)
	current_scene.set_reset_level_state(reset_level_state)

	current_scene.level_state_scene_finished.connect(change_state)


func unhandled_input(event):
	if event.is_action_pressed("pause_game"):
		current_scene.switch_to_level_state(previous_state)
