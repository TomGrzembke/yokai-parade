extends Node2D


func _ready() -> void:
	var player_scene = preload("res://player/player.tscn")
	
	var player = player_scene.instantiate()
	player.transform = $PlayerSpawnPoint.transform

	var camera = Camera2D.new()
	camera.position_smoothing_enabled = true
	camera.position_smoothing_speed = 10.0
	
	player.add_child(camera)
		
	get_parent().add_child.call_deferred(player)
