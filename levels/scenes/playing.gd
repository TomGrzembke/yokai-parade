extends Node

var state_node


func set_state_node(node):
	state_node = node


func set_play_time(play_time):
	%PlayTimeLabel.text = "%5.2f" % play_time
