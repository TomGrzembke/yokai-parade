extends Node2D


var player_spawn_position:
	get:
		return $PlayerSpawnPoint.position


func _on_despawn_area_body_entered(body):
	if body.has_method("despawn"):
		body.despawn()
