extends Node


var state_node


func _ready():
	await %AnimationPlayer.animation_finished

	state_node.change_to_next_game_state()


# Game States

func set_state_node(node):
	state_node = node
