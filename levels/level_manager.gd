extends Node


signal level_loaded(player_spawn_position)


@export var levels: Array[PackedScene]


var player_spawn_position = null


var _current_level = null:
	set = _set_current_level

var number_of_levels:
	get:
		return levels.size()


func _set_current_level(new_level):
	if _current_level != null:
		_current_level.queue_free()

	_current_level = new_level

	add_child.call_deferred(_current_level)


func load_level(level_index) -> bool:
	var success = false

	if level_index < levels.size() \
	and levels[level_index] != null:
		var level = levels[level_index].instantiate()
		_current_level = level
		if player_spawn_position == null:
			player_spawn_position = level.player_spawn_position
		if player_spawn_position == null:
			print("Level is missing PlayerSpawnPoint!")
		else:
			_current_level.set_player_spawn_position(player_spawn_position)
			level_loaded.emit(player_spawn_position)
			success = true

	return success


func set_player_spawn_position(position):
	player_spawn_position = position
