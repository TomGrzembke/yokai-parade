extends RayCast2D

var initial_length

func _ready():
	initial_length = target_position.length()


func has_target():
	return is_colliding()


func get_target():
	if !has_target(): return null
	return get_collider()


func lookat_direction(target_pos):
	var look_pos = to_local(target_pos)
	target_position = look_pos.normalized() * initial_length
