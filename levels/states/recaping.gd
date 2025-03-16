extends LevelState


@export var increment_level_state: LevelState
@export var game_over_level_state: LevelState
@export var return_to_main_menu_level_state: LevelState
@export var reset_level_state: LevelState
@export var quit_game_level_state: LevelState

var current_level_index
var first_level_index
var level_count


func enter(p_previous_state):
	super.enter(p_previous_state)

	state_scene.set_increment_level_state(increment_level_state)
	state_scene.set_game_over_level_state(game_over_level_state)
	state_scene.set_return_to_main_menu_level_state(return_to_main_menu_level_state)
	state_scene.set_reset_level_state(reset_level_state)
	state_scene.set_quit_game_level_state(quit_game_level_state)

	state_scene.update_level_info(context.get_current_level_info())
	state_scene.update_play_time(context.get_play_time())

	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func exit():
	super.exit()

	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
