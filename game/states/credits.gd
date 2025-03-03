extends GameState


# Game States

func enter(p_previous_state):
	super.enter(p_previous_state)

	state_scene.set_state_node(self)


func change_to_previous_state():
	change_state(previous_state)
