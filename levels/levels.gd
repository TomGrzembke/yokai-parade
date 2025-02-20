extends Node


signal level_load_completed(level_packed_scene)


@export var level_paths: Array[String]

var current_level_path_index
var currently_loading_level_path

var player_spawn_position


func try_changing_to_previous_level():
	var requested_level_path_index

	if current_level_path_index == null:
		requested_level_path_index = 0
	else:
		requested_level_path_index = current_level_path_index - 1

	return await try_changing_to_level(requested_level_path_index)


func try_changing_to_next_level():
	var requested_level_path_index

	if current_level_path_index == null:
		requested_level_path_index = 0
	else:
		requested_level_path_index = current_level_path_index + 1

	return await try_changing_to_level(requested_level_path_index)


func try_changing_to_level(level_index):
	var was_successful = false

	if level_index >= 0 \
	and level_index < level_paths.size():
		var level_path = level_paths[level_index]
		was_successful = await try_loading_level(level_path)
	if was_successful:
		current_level_path_index = level_index

	return was_successful


func try_loading_level(level_path):
	var was_successful = false

	currently_loading_level_path = level_path

	ResourceLoader.load_threaded_request(currently_loading_level_path)
	var level_packed_scene = await level_load_completed

	currently_loading_level_path = null

	if level_packed_scene == null:
		return was_successful

	set_current_level(level_packed_scene)
	was_successful = true

	return was_successful
	# Tell scene that loading is finished (loading progress back to null)
	#current_scene.set_start_button_enabled(true)


func clear_current_level():
	var current_level = get_current_level()
	if current_level != null:
		%CurrentLevel.remove_child(current_level)


func set_current_level(level_packed_scene):
	clear_current_level()

	var level_scene = level_packed_scene.instantiate()

	%CurrentLevel.add_child(level_scene)


func get_current_level():
	if current_level_path_index == null:
		return null

	var current_level

	for child in %CurrentLevel.get_children():
		if child.scene_file_path == level_paths[current_level_path_index]:
			current_level = child

	return current_level


func _physics_process(_delta):
	if currently_loading_level_path == null:
		return

	match ResourceLoader.load_threaded_get_status(currently_loading_level_path):
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS:
			# Update progress and push change to progress bar in scene
			var progress = []
			ResourceLoader.load_threaded_get_status(currently_loading_level_path, progress)
			#if progress.size() > 0:
				#current_scene.set_level_loading_progress(progress.front())
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
			var level_packed_scene = ResourceLoader.load_threaded_get(currently_loading_level_path)
			level_load_completed.emit(level_packed_scene)

		_:
			printerr("Error: Loading %s failed." % currently_loading_level_path)
			level_load_completed.emit(null)


func get_player_spawn_position():
	if player_spawn_position == null:
		player_spawn_position = get_current_level().get_player_spawn_position()

	if player_spawn_position == null:
		printerr("Error: Current level is missing a player spawn point!")

	return player_spawn_position


func on_player_reached_checkpoint(position):
	player_spawn_position = position


func spawn_player():
	var player = %CurrentLevel.get_node_or_null("Player")
	if player != null:
		player.clear_abilities()
	else:
		var player_scene = preload("res://player/player.tscn")
		player = player_scene.instantiate()
		#player.player_despawned.connect(on_player_despawned)
		#player.player_reached_goal.connect(on_player_reached_goal)
		player.player_reached_checkpoint.connect(on_player_reached_checkpoint)

		var remote_transform = RemoteTransform2D.new()
		remote_transform.remote_path = %PlayerCamera.get_path()
		player.add_child(remote_transform)

		%CurrentLevel.add_child.call_deferred(player)

	player.position = get_player_spawn_position()
