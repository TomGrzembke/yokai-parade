class_name LevelState
extends State


@export var level_state_packed_scene: PackedScene

var current_scene


func enter(p_previous_state):
	super.enter(p_previous_state)

	if level_state_packed_scene != null:
		current_scene = level_state_packed_scene.instantiate()
		parent.load_level_state_scene(current_scene)


func exit():
	if current_scene != null:
		parent.unload_level_state_scene(current_scene)


func change_state(next_level_state):
	parent.switch_to_level_state(next_level_state)
