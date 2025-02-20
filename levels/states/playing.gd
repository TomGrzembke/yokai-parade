extends LevelState


@export var paused_level_state: LevelState
@export var despawning_level_state: LevelState
@export var finishing_level_state: LevelState


func enter(p_previous_state):
	super.enter(p_previous_state)

	parent.set_game_paused(false)


func process(delta):
	var play_time = parent.get_play_time()
	parent.set_play_time(play_time + delta)


func unhandled_input(event):
	if event.is_action_pressed("pause_game"):
		return paused_level_state

	if event.is_action_pressed("reset_checkpoint"):
		print("resetting checkpoint")

	if event.is_action_pressed("reset_level"):
		#player_spawn_position = null
		print("resetting level")

	if event.is_action_pressed("load_next_level"):
		pass
		#var desired_level_index = current_level_index + 1
		#if desired_level_index >= %Levels.get_number_of_levels():
			#print("Already at last level.")
			#desired_level_index = current_level_index
			#return
		#player_spawn_position = null

	if event.is_action_pressed("load_previous_level"):
		pass
		#var desired_level_index = current_level_index - 1
		#if desired_level_index < 0:
			#print("Already at first level.")
			#desired_level_index = current_level_index
			#return
		#player_spawn_position = null
