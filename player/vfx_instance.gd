extends Node2D
@onready var anim_sprite
var rigid_body
var freeze_physics
var flip_parent
var moved = false
var clear_after_move


func play(animation_name, emit_in_global = false, _freeze_physics = false, _z_index = null, _flip_parent = null, _clear_after_move = false):
	rigid_body = $RigidBody2D
	anim_sprite = $RigidBody2D/AnimatedSprite2D
	flip_parent = _flip_parent
	clear_after_move = _clear_after_move

	if !has_anim(animation_name):
		queue_free()
		return

	anim_sprite.play(animation_name, 1.0, false)
	if emit_in_global: call_deferred("to_root")

	call_deferred("reset_rb")
	freeze_physics = _freeze_physics
	rigid_body.freeze = freeze_physics

	if _z_index != null:
		anim_sprite.z_index = _z_index


func to_root():
	reparent(get_tree().root)


func _physics_process(_delta):
	flip()

	clear_after_action()

	reset_rb()


func flip():
	if flip_parent == null: return

	set_rotation_degrees(-180.0 if flip_parent.look_direction == -1.0 else 0.0)
	scale.y = flip_parent.look_direction


func clear_after_action():
	if !clear_after_move: return
	if !moved: return

	queue_free()


func _unhandled_input(_event):
	moved = true


func has_anim(animation_name):
	return anim_sprite.sprite_frames.has_animation(animation_name)


func on_animation_finished():
	queue_free()
	pass


func reset_rb():
	if rigid_body != null && rigid_body.freeze: return
	if rigid_body != null && rigid_body.get_linear_velocity() == Vector2.ZERO:
		rigid_body.freeze = true

	if flip_parent != null: return
	if scale.y == 1 && rotation == 0 && (rigid_body == null || rigid_body.rotation == 0): return

	scale.y = 1
	rotation = 0
	rigid_body.rotation = 0
