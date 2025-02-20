extends LevelStateScene


var next_level_state


func set_next_level_state(state):
	next_level_state = state


func switch_to_next_level_state():
	%AnimationPlayer.stop()
	%AnimationPlayer.play("show_level")
	await %AnimationPlayer.animation_finished
	level_state_scene_finished.emit(next_level_state)
