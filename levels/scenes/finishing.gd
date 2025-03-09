extends Node


signal music_volume_fraction_changed(fraction)


@export var music_volume_fraction: float:
	set(fraction):
		music_volume_fraction_changed.emit(fraction)

var state_node


# Workaround for bug in Godot that happens when AudiosStreamPlayer is started from AnimationPlayer
func play_fanfare():
	%AudioStreamPlayer.play()


# Level States

func _ready():
	await %AnimationPlayer.animation_finished

	change_to_next_level_state()


func set_state_node(node):
	state_node = node


func change_to_next_level_state():
	%AnimationPlayer.queue("fading_outro_long")
	await %AnimationPlayer.animation_finished

	state_node.change_to_next_level_state()
