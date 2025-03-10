extends Node2D


@export var entity: Node2D

var state_animations_scene
var facing_direction


func _ready():
	state_animations_scene = entity.get_element_animations_scene_instance()
	add_child(state_animations_scene)

	state_animations_scene.position = entity.get_initial_position()
	set_facing_direction(entity.get_initial_facing_direction())


func set_state_node(node):
	state_animations_scene.set_state_node(node)


func set_facing_direction(value):
	facing_direction = value
	if facing_direction != null:
		state_animations_scene.update_direction(facing_direction)


func get_facing_direction():
	return facing_direction


func get_state_animations_scene():
	return state_animations_scene


func enter_state_idling():
	state_animations_scene.enter_state_idling()


func enter_state_moving():
	state_animations_scene.enter_state_moving()


func enter_state_lunging():
	await state_animations_scene.enter_state_lunging()


func enter_state_attacking():
	await state_animations_scene.enter_state_attacking()


func enter_state_recovering():
	await state_animations_scene.enter_state_recovering()
