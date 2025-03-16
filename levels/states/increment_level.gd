extends LevelState


@export var loading_level_state: LevelState
@export var game_over_level_state: LevelState

var next_level_state


func enter(p_previous_state):
	super.enter(p_previous_state)

	next_level_state = loading_level_state

	var result = context.increment_current_level_index()
	if result == Error.ERR_PARAMETER_RANGE_ERROR:
		next_level_state = game_over_level_state

	change_state(next_level_state)
