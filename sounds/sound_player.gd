extends AudioStreamPlayer2D


func emit_sound(sound : AudioStream):
	set_stream(sound)
	play()
