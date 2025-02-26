extends LevelState


@export var next_level_state: LevelState


func enter(p_previous_state):
	super.enter(p_previous_state)

	state_scene.set_state_node(self)


func unhandled_input(event):
	if event.is_action_pressed("skip"):
		change_to_next_level_state()


func change_to_next_level_state():
	change_state(next_level_state)
