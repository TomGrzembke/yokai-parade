extends Node


@export var initial_game_state: GameState
@export var title_music_stream: AudioStream
@export var game_music_stream: AudioStream

var current_game_state_scene


# Music

func get_is_music_playing():
	return %MusicPlayer.playing


func play_title_music():
	play_music(title_music_stream)


func play_game_music():
	play_music(game_music_stream)


func play_music(stream):
	if stream == %MusicPlayer.stream:
		return

	await fade_out_music(1.0)
	%MusicPlayer.stream = stream
	%MusicPlayer.playing = true


func fade_out_music(duration):
	if not %MusicPlayer.playing:
		return

	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(%MusicPlayer, "volume_db", -80.0, duration).from_current()

	await tween.finished
	%MusicPlayer.stop()
	%MusicPlayer.volume_db = 0.0


# State Machine

func _ready() -> void:
	%GameStateMachine.init(self, initial_game_state)


func _physics_process(delta):
	%GameStateMachine.physics_process(delta)


func _process(delta):
	%GameStateMachine.process(delta)


func _unhandled_input(event):
	%GameStateMachine.unhandled_input(event)


func _input(event):
	%GameStateMachine.input(event)


# Game States

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


func change_to_game_state(game_state):
	%GameStateMachine.change_state(game_state)
