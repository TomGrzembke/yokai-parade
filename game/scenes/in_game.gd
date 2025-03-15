extends Node


signal level_load_progress(progress)
signal level_cleared
signal player_despawned
signal player_reached_goal


@export_category("Level States")
@export var initial_level_state: LevelState

var state_node
var current_level_state_scene
var player
var play_time
var last_checkpoint_position


func _ready():
	%LevelHook.level_load_progress.connect(on_level_load_progress)
	%LevelHook.level_cleared.connect(func (): level_cleared.emit())

	reset_play_time()

	request_setting_next_level_path_index()
	%LevelStateMachine.init(self, initial_level_state)


# Options

func set_window_fullscreen(active):
	state_node.set_window_fullscreen(active)


func get_window_fullscreen():
	return state_node.get_window_fullscreen()


func set_volume_audio_bus(bus_id, volume_db):
	state_node.set_volume_audio_bus(bus_id, volume_db)


func get_volume_audio_bus(bus_id):
	return state_node.get_volume_audio_bus(bus_id)


# Music

func play_game_music():
	state_node.play_game_music()


func fade_to_game_over_music():
	state_node.fade_to_game_over_music()


func get_music_volume():
	return get_volume_audio_bus(1)


func set_music_volume(volume_db):
	set_volume_audio_bus(1, volume_db)


# Pausing

func set_game_paused(should_pause):
	get_tree().paused = should_pause


# Level Loading

func get_level_count():
	return %LevelCoordinator.get_level_path_count()


func  get_first_level_index():
	return %LevelCoordinator.get_first_level_path_index()


func get_current_level_index():
	return %LevelCoordinator.get_current_level_path_index()


func get_requested_level_path_index():
	return %LevelCoordinator.get_requested_level_path_index()


func request_setting_level_path_index(index):
	%LevelCoordinator.request_setting_level_path_index(index)


func request_setting_previous_level_path_index():
	%LevelCoordinator.request_setting_previous_level_path_index()


func request_setting_next_level_path_index():
	%LevelCoordinator.request_setting_next_level_path_index()


func try_changing_to_requested_level():
	return await %LevelCoordinator.try_changing_to_requested_level(%LevelHook)


func on_level_load_progress(progress):
	level_load_progress.emit(progress)


# Player

func spawn_player():
	if player != null:
		player.queue_free()

	var player_scene = preload("res://player/player.tscn")
	player = player_scene.instantiate()

	player.position = get_player_spawn_position()

	player.player_ability_changed.connect(on_player_ability_changed)
	player.player_despawned.connect(on_player_despawned)
	player.player_reached_checkpoint.connect(on_player_reached_checkpoint)
	player.player_reached_goal.connect(on_player_reached_goal)
	level_cleared.connect(player.reload)

	%Main.add_child.call_deferred(player)
	await player.tree_entered

	var remote_transform = RemoteTransform2D.new()
	remote_transform.remote_path = %PlayerCamera.get_path()

	player.set_cam_remote(remote_transform)


func get_player_spawn_position():
	var player_spawn_position = last_checkpoint_position

	if player_spawn_position == null:
		player_spawn_position = %LevelHook.get_initial_player_spawn_position()

	return player_spawn_position


func set_player_controls_active(active):
	if player == null:
		return

	player.set_controls_active(active)


func on_player_ability_changed(color):
	%CurrentAbility.change_with_color(color)


func on_player_despawned():
	player_despawned.emit()


func on_player_reached_checkpoint(position):
	last_checkpoint_position = position


func on_player_reached_goal():
	player_reached_goal.emit()


# Checkpoints

func get_is_past_first_checkpoint():
	return last_checkpoint_position != null


func reset_last_checkpoint_position():
	last_checkpoint_position = null


func reset_to_checkpoint():
	await spawn_player()


func load_currently_active_level():
	await %LevelHook.activate_current_level_packed_scene()
	reset_last_checkpoint_position()
	reset_play_time()
	await spawn_player()


# Play Time

func get_play_time():
	return play_time


func set_play_time(new_time):
	play_time = new_time
	%PlayTimeLabel.text = "%5.2f" % play_time


func reset_play_time():
	set_play_time(0.0)


# State Machine

func _physics_process(delta):
	%LevelStateMachine.physics_process(delta)


func _process(delta):
	%LevelStateMachine.process(delta)


func _unhandled_input(event):
	%LevelStateMachine.unhandled_input(event)


func _input(event):
	%LevelStateMachine.input(event)


# Level State

func load_level_state_scene(level_state_scene):
	current_level_state_scene = level_state_scene
	add_child(current_level_state_scene)


func unload_current_level_state_scene():
	if current_level_state_scene != null:
		current_level_state_scene.queue_free()
		await get_tree().process_frame


func change_to_level_state(level_state):
	%LevelStateMachine.change_state(level_state)


# Game States

func set_state_node(node):
	state_node = node


func change_to_main_menu_game_state():
	state_node.change_to_main_menu_game_state()


func change_to_quit_game_state():
	state_node.change_to_quit_game_state()
