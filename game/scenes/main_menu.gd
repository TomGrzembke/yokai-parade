extends Node


var state_node

var in_game_state
var options_game_state
var credits_game_state

func _ready():
	%StartButton.pressed.connect(change_to_in_game_state)
	%OptionsButton.pressed.connect(change_to_options_game_state)
	%CreditsButton.pressed.connect(change_to_credits_game_state)
	%QuitButton.pressed.connect(quit_game)
	%StartButton.grab_focus()


# Game States

func change_to_in_game_state():
	change_to_game_state(in_game_state)


func change_to_options_game_state():
	change_to_game_state(options_game_state)


func change_to_credits_game_state():
	change_to_game_state(credits_game_state)


func change_to_game_state(next_game_state):
	%AnimationPlayer.stop()
	%AnimationPlayer.play("state_transitions_long/hide_state_scene")
	await %AnimationPlayer.animation_finished
	state_node.change_state(next_game_state)


func quit_game():
	%AnimationPlayer.stop()
	%AnimationPlayer.play("game_quit_transitions/blackout")
	await %AnimationPlayer.animation_finished
	get_tree().quit()


func set_state_node(node):
	state_node = node


func set_in_game_state(state):
	in_game_state = state


func set_options_game_state(state):
	options_game_state = state


func set_credits_game_state(state):
	credits_game_state = state
