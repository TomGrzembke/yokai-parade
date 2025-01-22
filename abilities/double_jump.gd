extends Node2D

@export var air_power_jump_velocity = 800.0


func use(player_manager):
	var vel_modifier = VelocityModifier.new(Vector2(0, -air_power_jump_velocity), 2, 1, false)
	player_manager.add_velocity_modifier(vel_modifier)
