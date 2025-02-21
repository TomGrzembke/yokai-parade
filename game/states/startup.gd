extends GameState


@export var next_game_state: GameState


func enter(p_previous_state):
	super.enter(p_previous_state)

	state_scene.set_state_node(self)


func change_to_next_game_state():
	change_state(next_game_state)
