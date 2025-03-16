extends LevelState


@export var loading_level_state: LevelState


func enter(p_previous_state):
	super.enter(p_previous_state)

	context.decrement_current_level_index()

	change_state(loading_level_state)
