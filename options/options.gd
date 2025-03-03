extends Control


signal window_fullscreen_changed(active)
signal volume_audio_bus_changed(bus_id, volume_db)
signal back_button_pressed()


func _ready():
	%FullscreenCheckBox.toggled.connect(func (active): window_fullscreen_changed.emit(active))

	%VolumeMasterSlider.value_changed.connect(
		func (volume_linear): volume_audio_bus_changed.emit(0, volume_linear)
	)
	%VolumeMusicSlider.value_changed.connect(
		func (volume_linear): volume_audio_bus_changed.emit(1, volume_linear)
	)
	%VolumeSfxSlider.value_changed.connect(
		func (volume_linear): volume_audio_bus_changed.emit(2, volume_linear)
	)
	%VolumeUiSlider.value_changed.connect(
		func (volume_linear): volume_audio_bus_changed.emit(3, volume_linear)
	)

	%VolumeSfxSlider.drag_started.connect(loop_sfx_sound)
	%VolumeSfxSlider.drag_ended.connect(stop_sound_loop)

	%VolumeUiSlider.drag_started.connect(loop_ui_sound)
	%VolumeUiSlider.drag_ended.connect(stop_sound_loop)

	%BackButton.pressed.connect(func (): back_button_pressed.emit())
	%BackButton.grab_focus()


func update_window_fullscreen_checkbox(active):
	%FullscreenCheckBox.set_pressed_no_signal(active)


func update_volume_master_slider(volume_linear):
	%VolumeMasterSlider.set_value_no_signal(volume_linear)


func update_volume_music_slider(volume_linear):
	%VolumeMusicSlider.set_value_no_signal(volume_linear)


func update_volume_sfx_slider(volume_linear):
	%VolumeSfxSlider.set_value_no_signal(volume_linear)


func update_volume_ui_slider(volume_linear):
	%VolumeUiSlider.set_value_no_signal(volume_linear)


func loop_sfx_sound():
	%AnimationPlayer.play("loop_sfx_sound")


func loop_ui_sound():
	%AnimationPlayer.play("loop_ui_sound")


func stop_sound_loop(_changed):
	%AnimationPlayer.stop()
