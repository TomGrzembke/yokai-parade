extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var mesh_instance_2d: MeshInstance2D = $MeshInstance2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func took_fire_damage(_source):
	animation_player.play("break")
	mesh_instance_2d.visible = false
	collision_shape_2d.disabled = true
