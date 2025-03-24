extends Node


var state_node


# Level States

func set_state_node(node):
	state_node = node


func _ready():
	await %AnimationPlayer.animation_finished
	await state_node.reset_to_checkpoint()
	change_level_state()


func change_level_state():
	%AnimationPlayer.stop()
	%AnimationPlayer.play("state_transitions_short/hide_state_scene")
	await %AnimationPlayer.animation_finished

	state_node.change_to_next_level_state()
