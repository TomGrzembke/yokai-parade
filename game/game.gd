extends Node


const STATE = preload("res://components/state_machine/state.gd")

@export var initial_state: STATE

# TODO: Remove this
enum GameState {
	STARTING_GAME = 0,
	LOADING_LEVEL = 500,
	PLAYING_LEVEL = 600,
}

# TODO: Move this to InGame state
var current_level_index = 0
var player_spawn_position = null
var is_play_timer_running = false
var play_time = 0.0
# TODO: Replace with state machine
var state = GameState.STARTING_GAME

var current_game_state_scene


func _ready() -> void:
	%StateMachine.init(self, initial_state)
	# Old
	#load_level(0)
	#spawn_player()
	#start_timer()
	#enter_state(GameState.PLAYING_LEVEL)


func _process(delta):
	if is_play_timer_running:
		set_play_time(play_time + delta)


func _unhandled_input(_event):
	if state == GameState.LOADING_LEVEL:
		return

	if Input.is_action_just_pressed("reset_level"):
		enter_state(GameState.LOADING_LEVEL)
		player_spawn_position = null
		load_level(current_level_index)
		spawn_player()
		start_timer()
		await get_tree().create_timer(1.0).timeout
		enter_state(GameState.PLAYING_LEVEL)

	if Input.is_action_just_pressed("reset_checkpoint"):
		enter_state(GameState.LOADING_LEVEL)
		load_level(current_level_index)
		spawn_player()
		enter_state(GameState.PLAYING_LEVEL)

	if Input.is_action_just_pressed("load_next_level"):
		enter_state(GameState.LOADING_LEVEL)
		var desired_level_index = current_level_index + 1
		if desired_level_index >= %Levels.get_number_of_levels():
			print("Already at last level.")
			desired_level_index = current_level_index
			enter_state(GameState.PLAYING_LEVEL)
			return
		player_spawn_position = null
		load_level(desired_level_index)
		spawn_player()
		start_timer()
		enter_state(GameState.PLAYING_LEVEL)

	if Input.is_action_just_pressed("load_previous_level"):
		enter_state(GameState.LOADING_LEVEL)
		var desired_level_index = current_level_index - 1
		if desired_level_index < 0:
			print("Already at first level.")
			desired_level_index = current_level_index
			enter_state(GameState.PLAYING_LEVEL)
			return
		player_spawn_position = null
		load_level(desired_level_index)
		spawn_player()
		start_timer()
		enter_state(GameState.PLAYING_LEVEL)

# New Stuff

func load_game_state_scene(game_state_scene):
	current_game_state_scene = game_state_scene
	add_child(current_game_state_scene)


func unload_game_state_scene(game_state_scene):
	var scene_to_be_removed
	for child in get_children():
		if child == game_state_scene:
			scene_to_be_removed = game_state_scene
	if scene_to_be_removed != null:
		remove_child(scene_to_be_removed)


func change_to_game_state(game_state: GameState):
	%StateMachine.change_state(game_state)


func enter_state(new_state):
	match new_state:
		GameState.PLAYING_LEVEL:
			Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		_:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	state = new_state


func load_level(desired_level_index):
	var loaded_successfully = %Levels.load_level(desired_level_index)
	if not loaded_successfully:
		printerr("Error: Level could not be loaded!")
	current_level_index = desired_level_index


func set_play_time(new_time):
	play_time = new_time
	%PlayTimeLabel.text = "%5.2f" % play_time


func start_timer():
	set_play_time(0.0)
	is_play_timer_running = true


func stop_timer():
	is_play_timer_running = false


func get_player_spawn_position():
	if player_spawn_position == null:
		player_spawn_position = %Levels.get_player_spawn_position_of_level()

	return player_spawn_position


func spawn_player():
	var player = null
	if get_node_or_null("Player") != null:
		player = $Player
		player.clear_abilities()
	else:
		var player_scene = preload("res://player/player.tscn")
		player = player_scene.instantiate()
		player.player_despawned.connect(on_player_despawned)
		player.player_reached_goal.connect(on_player_reached_goal)
		player.player_reached_checkpoint.connect(on_player_reached_checkpoint)

		var camera_node = get_tree().root.get_node_or_null("Game/Camera2D")

		var remote_transform = RemoteTransform2D.new()
		remote_transform.remote_path = camera_node.get_path()
		player.add_child(remote_transform)

		add_child.call_deferred(player)

	#player.position = get_player_spawn_position()


func on_player_despawned():
	if get_node_or_null("Player") != null:
		await $Player.tree_exited

	load_level(current_level_index)
	spawn_player()


func on_player_reached_goal():
	stop_timer()


func on_player_reached_checkpoint(position):
	player_spawn_position = position
