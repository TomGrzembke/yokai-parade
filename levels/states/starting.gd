extends LevelState


@export var playing_level_state: LevelState
@export var paused_level_state: LevelState


func enter(p_previous_state):
	super.enter(p_previous_state)
	current_scene.set_playing_level_state(playing_level_state)
	current_scene.set_paused_level_state(paused_level_state)

	current_scene.level_state_scene_finished.connect(change_state)
