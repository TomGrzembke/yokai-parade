extends LevelState


@export var playing_level_state: LevelState
@export var reset_level_state: LevelState

var next_state


func enter(p_previous_state):
	super.enter(p_previous_state)

	if context.get_is_past_first_checkpoint():
		next_state = playing_level_state
	else:
		next_state = reset_level_state


func change_to_next_level_state():
	change_state(next_state)


func reset_to_checkpoint():
	await context.reset_to_checkpoint()
