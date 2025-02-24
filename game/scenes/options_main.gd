extends Node


var state_node


func _ready():
	%BackButton.pressed.connect(change_to_previous_state)


# Game States

func set_state_node(node):
	state_node = node


func change_to_previous_state():
	%AnimationPlayer.stop()
	%AnimationPlayer.play("state_transitions_long/hide_state_scene")
	await %AnimationPlayer.animation_finished

	state_node.change_to_previous_state()
