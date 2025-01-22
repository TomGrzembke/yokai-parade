extends Node2D

@export var fire_power_dash_velocity = 300.0
@export var fire_power_dash_duration = 1.0


func use(player_manager):
	var vel_modifier = VelocityModifier.new(Vector2(fire_power_dash_velocity, 0), 2, 1, true)
	player_manager.add_velocity_modifier(vel_modifier)
