extends LevelState


@export var next_level_state: LevelState


func enter(p_previous_state):
	super.enter(p_previous_state)
	state_scene.set_state_node(self)

	parent.level_load_progress.connect(func(progress): state_scene.update_progress_bar(progress))
	state_scene.level_loading_ready.connect(load_level)

	parent.set_game_paused(true)


func change_to_next_level_state():
	change_state(next_level_state)


func load_level():
	var succeeded = await parent.try_changing_to_requested_level()

	if succeeded == true:
		await parent.spawn_player()
		state_scene.set_start_button_enabled(true)
		state_scene.update_progress_bar(1)
	else:
		printerr("Error: Loading of level failed!")
