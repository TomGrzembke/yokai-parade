extends LevelState


func set_window_fullscreen(is_on):
	context.set_window_fullscreen(is_on)


func get_window_fullscreen():
	return context.get_window_fullscreen()


func set_volume_audio_bus(bus_id, volume_db):
	context.set_volume_audio_bus(bus_id, volume_db)


func get_volume_audio_bus(bus_id):
	return context.get_volume_audio_bus(bus_id)


# Level States

func enter(p_previous_state):
	super.enter(p_previous_state)

	context.set_game_paused(true)

	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	state_scene.update_window_fullscreen(get_window_fullscreen())

	state_scene.update_volume_master(get_volume_audio_bus(0))
	state_scene.update_volume_music(get_volume_audio_bus(1))
	state_scene.update_volume_sfx(get_volume_audio_bus(2))
	state_scene.update_volume_ui(get_volume_audio_bus(3))


func exit():
	super.exit()

	context.set_game_paused(false)

	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func change_to_previous_level_state():
	change_state(previous_state)
