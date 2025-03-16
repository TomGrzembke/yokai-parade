extends Node


signal level_load_progress(progress)
signal level_load_completed(level_packed_scene)
signal level_cleared


var currently_loading_level_path
var current_level_packed_scene
var current_level_scene


func _physics_process(_delta):
	if currently_loading_level_path == null:
		return

	match ResourceLoader.load_threaded_get_status(currently_loading_level_path):
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS:
			var progress = []
			ResourceLoader.load_threaded_get_status(currently_loading_level_path, progress)
			if progress.size() > 0:
				level_load_progress.emit(progress.front())
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
			var level_packed_scene = ResourceLoader.load_threaded_get(currently_loading_level_path)
			level_load_completed.emit(level_packed_scene)

		_:
			printerr("Error: Loading %s failed." % currently_loading_level_path)
			level_load_completed.emit(null)


func load_level(level_path):
	currently_loading_level_path = level_path

	ResourceLoader.load_threaded_request(currently_loading_level_path)
	current_level_packed_scene = await level_load_completed

	currently_loading_level_path = null

	if current_level_packed_scene == null:
		return Error.ERR_FILE_BAD_PATH

	await activate_current_level_packed_scene()

	return Error.OK


func activate_current_level_packed_scene():
	await clear_current_level()

	current_level_scene = current_level_packed_scene.instantiate()

	add_child(current_level_scene)


func clear_current_level():
	if current_level_scene != null:
		current_level_scene.queue_free()
		await get_tree().process_frame

		level_cleared.emit()


func get_initial_player_spawn_position():
	var player_spawn_position = current_level_scene.get_player_spawn_position()

	if player_spawn_position == null:
		printerr("Error: Current level is missing a player spawn point!")

	return player_spawn_position
