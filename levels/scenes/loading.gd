extends LevelStateScene


signal level_loading_ready

var next_level_state
var progress


func _ready():
	%StartButton.pressed.connect(switch_to_next_level_state)


func set_next_level_state(state):
	next_level_state = state


func switch_to_next_level_state():
	%AnimationPlayer.stop()
	%AnimationPlayer.play("fade_out")
	await %AnimationPlayer.animation_finished
	level_state_scene_finished.emit(next_level_state)


func set_start_button_enabled(enabled):
	%StartButton.disabled = not enabled


func emit_level_loading_ready_signal():
	level_loading_ready.emit()
