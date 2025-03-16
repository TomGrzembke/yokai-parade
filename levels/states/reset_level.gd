extends LevelState


@export var next_level_state: LevelState


func enter(p_previous_state):
	super.enter(p_previous_state)

	await context.load_current_level()
	change_state(next_level_state)
