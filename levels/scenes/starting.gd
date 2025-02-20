extends LevelStateScene


var playing_level_state
var paused_level_state


func set_playing_level_state(state):
	playing_level_state = state


func set_paused_level_state(state):
	paused_level_state = state


func _ready():
		%AnimationPlayer.play("countdown")


func switch_to_playing_level_state():
	switch_to_next_level_state(playing_level_state)


func switch_to_paused_level_state():
	switch_to_next_level_state(paused_level_state)


func switch_to_next_level_state(state):
	level_state_scene_finished.emit(state)
