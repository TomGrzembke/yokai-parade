extends LevelState


@export var next_level_state: LevelState


func enter(p_previous_state):
	super.enter(p_previous_state)

	context.level_load_progress.connect(func(progress): state_scene.update_progress(progress))

	context.set_game_paused(true)


func exit():
	super.exit()

	context.set_game_paused(false)


func change_to_next_level_state():
	change_state(next_level_state)


func load_current_level():
	await context.load_current_level()

	state_scene.update_progress(1.0)
