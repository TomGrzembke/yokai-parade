extends LevelState


@export var next_level_state: LevelState


func enter(p_previous_state):
	super.enter(p_previous_state)
	current_scene.set_next_level_state(next_level_state)

	current_scene.level_state_scene_finished.connect(change_state)
	current_scene.level_loading_ready.connect(load_level)

	parent.set_game_paused(true)


func load_level():
	var level_loading_succeeded = await parent.try_changing_to_next_level()

	if level_loading_succeeded == true:
		parent.spawn_player()
		current_scene.set_start_button_enabled(true)
	else:
		printerr("Error: Loading of level failed!")
