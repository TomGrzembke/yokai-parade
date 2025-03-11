extends LevelState


@export var playing_level_state: LevelState
@export var reset_level_state: LevelState


func enter(p_previous_state):
	if not context.get_is_past_first_checkpoint():
		change_to_reset_level_state()

	super.enter(p_previous_state)


func change_to_reset_level_state():
	change_state(reset_level_state)


func change_to_playing_level_state():
	change_state(playing_level_state)


func reset_to_checkpoint():
	await context.reset_to_checkpoint()
