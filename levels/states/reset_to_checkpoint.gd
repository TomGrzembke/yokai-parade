extends LevelState


@export var next_level_state: LevelState


func enter(p_previous_state):
	super.enter(p_previous_state)
	current_scene.set_next_level_state(next_level_state)

	current_scene.level_state_scene_finished.connect(change_state)


func reset_to_checkpoint():
	parent.reset_to_checkpoint()
