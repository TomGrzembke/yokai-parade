extends Node


var state_node


func _ready():
	await %AnimationPlayer.animation_finished

	await state_node.reset_level()

	change_to_next_level_state()


# Level States

func set_state_node(node):
	state_node = node


func change_to_next_level_state():
	state_node.change_to_next_level_state()
