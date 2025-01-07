extends Marker2D


func _ready() -> void:
	var player_scene = preload("res://player/player.tscn")
	
	var player = player_scene.instantiate()
	player.transform = transform
	get_parent().add_child.call_deferred(player)
