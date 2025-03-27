extends LevelState


@export var decrement_level_state: LevelState
@export var increment_level_state: LevelState
@export var paused_level_state: LevelState
@export var reset_to_checkpoint_level_state: LevelState
@export var reset_level_state: LevelState
@export var finishing_level_state: LevelState


func enter(p_previous_state):
	super.enter(p_previous_state)

	context.player_despawned.connect(func(): change_state(reset_to_checkpoint_level_state))
	context.player_reached_goal.connect(func(): change_state(finishing_level_state))

	context.set_player_controls_active(true)


func process(delta):
	var play_time = context.get_play_time()
	context.set_play_time(play_time + delta)


func unhandled_input(event):
	if event.is_action_pressed("pause_game"):
		return paused_level_state

	if event.is_action_pressed("reset_to_checkpoint"):
		return reset_to_checkpoint_level_state

	if event.is_action_pressed("reset_level"):
		return reset_level_state

	if not OS.has_feature("debug"):
		return

	if event.is_action_pressed("load_previous_level"):
		return decrement_level_state

	if event.is_action_pressed("load_next_level"):
		return increment_level_state

	if event.is_action_pressed("debug_screenshot_pause"):
		context.set_game_paused(!get_tree().paused)
