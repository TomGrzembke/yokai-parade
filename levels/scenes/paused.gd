extends LevelStateScene


var previous_level_state
var options_in_game_level_state
var return_to_main_menu_level_state
var reset_to_checkpoint_level_state
var reset_level_state


func _ready():
	%ResumeButton.pressed.connect(switch_to_previous_level_state)
	%OptionsButton.pressed.connect(switch_to_options_in_game_level_state)
	%ReturnToMainMenuButton.pressed.connect(switch_to_return_to_main_menu_state)
	%ResetCheckpointButton.pressed.connect(switch_to_reset_to_checkpoint_level_state)
	%ResetLevelButton.pressed.connect(switch_to_reset_level_state)
	%QuitGameButton.pressed.connect(quit_game)


func set_previous_level_state(state):
	previous_level_state = state


func set_options_in_game_level_state(state):
	options_in_game_level_state = state


func set_return_to_main_menu_level_state(state):
	return_to_main_menu_level_state = state


func set_reset_checkpoint_level_state(state):
	reset_to_checkpoint_level_state = state


func set_reset_level_state(state):
	reset_level_state = state


func switch_to_previous_level_state():
	switch_to_level_state(previous_level_state)


func switch_to_options_in_game_level_state():
	switch_to_level_state(options_in_game_level_state)


func switch_to_return_to_main_menu_state():
	switch_to_level_state(return_to_main_menu_level_state)


func switch_to_reset_to_checkpoint_level_state():
	switch_to_level_state(reset_to_checkpoint_level_state)


func switch_to_reset_level_state():
	switch_to_level_state(reset_level_state)


func switch_to_level_state(level_state):
	%AnimationPlayer.stop()
	%AnimationPlayer.play("fade_out")
	await %AnimationPlayer.animation_finished
	level_state_scene_finished.emit(level_state)


func quit_game():
	%AnimationPlayer.stop()
	%AnimationPlayer.play("fade_out")
	await %AnimationPlayer.animation_finished
	get_tree().quit()
