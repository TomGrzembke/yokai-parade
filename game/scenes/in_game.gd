extends GameStateScene


@export_category("Level States")
@export var initial_level_state: LevelState

var play_time
var main_menu_game_state
var current_level_state_scene


func _ready():
	reset_play_time()
	%LevelStateMachine.init(self, initial_level_state)


func _physics_process(delta):
	%LevelStateMachine.physics_process(delta)


func _process(delta):
	%LevelStateMachine.process(delta)


func _unhandled_input(event):
	%LevelStateMachine.unhandled_input(event)


func _input(event):
	%LevelStateMachine.input(event)


func set_game_paused(should_pause):
	get_tree().paused = should_pause


func get_play_time():
	return play_time


func set_play_time(new_time):
	play_time = new_time
	%PlayTimeLabel.text = "%5.2f" % play_time


func reset_play_time():
	set_play_time(0.0)


# Level Loading

func try_changing_to_previous_level():
	return await %Levels.try_changing_to_previous_level()


func try_changing_to_next_level():
	return await %Levels.try_changing_to_next_level()


func clear_current_level():
	%Levels.clear_current_level()


func spawn_player():
	%Levels.spawn_player()


# Level State

func load_level_state_scene(level_state_scene):
	current_level_state_scene = level_state_scene
	add_child(current_level_state_scene)


func unload_level_state_scene(level_state_scene):
	var scene_to_be_removed
	for child in get_children():
		if child == level_state_scene:
			scene_to_be_removed = level_state_scene
	if scene_to_be_removed != null:
		remove_child(scene_to_be_removed)


func switch_to_level_state(level_state):
	%LevelStateMachine.change_state(level_state)


# GameState

func set_main_menu_game_state(state):
	main_menu_game_state = state


func switch_to_main_menu_game_state():
	switch_to_game_state(main_menu_game_state)


func switch_to_game_state(next_game_state):
	game_state_scene_finished.emit(next_game_state)


# OLD STUFF!!!!!!!!!!!!!!!!!!!!!!!!!!

#func on_player_despawned():
	#if get_node_or_null("Player") != null:
		#await $Player.tree_exited
#
	#load_level(current_level_index)
	#spawn_player()
