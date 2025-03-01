extends GameState


func enter(p_previous_state):
	super.enter(p_previous_state)

	state_scene.set_state_node(self)


func fade_out_music(duration):
	await parent.fade_out_music(duration)
