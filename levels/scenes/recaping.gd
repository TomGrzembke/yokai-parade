extends Node


var play_time

var state_node

var increment_level_state
var game_over_level_state
var return_to_main_menu_level_state
var reset_level_state
var quit_game_level_state


func _ready():
	await %AnimationPlayer.animation_finished

	%NextLevelButton.pressed.connect(change_to_increment_level_state)
	%ResetLevelButton.pressed.connect(change_to_reset_level_state)
	%ReturnToMainMenuButton.pressed.connect(change_to_return_to_main_menu_state)
	%QuitGameButton.pressed.connect(change_to_quit_game_level_state)

	%NextLevelButton.grab_focus()


func update_level_info(level_info):
	var info_text = "Completed\n %s!" % level_info.name
	%LevelInfoLabel.text = info_text


func update_play_time(p_play_time):
	play_time = p_play_time
	%PlayTimeLabel.text = "%5.2f" % play_time


# Level States

func set_state_node(node):
	state_node = node


func set_increment_level_state(state):
	increment_level_state = state


func set_game_over_level_state(state):
	game_over_level_state = state


func set_return_to_main_menu_level_state(state):
	return_to_main_menu_level_state = state


func set_reset_level_state(state):
	reset_level_state = state


func set_quit_game_level_state(state):
	quit_game_level_state = state


func change_to_increment_level_state():
	change_to_level_state(increment_level_state)


func change_to_return_to_main_menu_state():
	change_to_level_state(return_to_main_menu_level_state)


func change_to_reset_level_state():
	change_to_level_state(reset_level_state)


func change_to_quit_game_level_state():
	change_to_level_state(quit_game_level_state)


func exit_state_transition():
	%AnimationPlayer.stop()
	%AnimationPlayer.play("state_transitions_long/hide_state_scene")
	await %AnimationPlayer.animation_finished


func change_to_level_state(level_state):
	await exit_state_transition()

	state_node.change_state(level_state)
