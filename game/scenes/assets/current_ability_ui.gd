extends TextureRect

const ELEMENTS = preload("res://elements/elements.gd")

var default_frame
@export var air_frame : Texture2D
@export var fire_frame : Texture2D


func _ready():
	default_frame = texture


func change_with_color(color):
	if color == ELEMENTS.COLOR_MAP[ELEMENTS.ElementType.AIR]:
		texture = air_frame
	elif color == ELEMENTS.COLOR_MAP[ELEMENTS.ElementType.FIRE]:
		texture = fire_frame
	else:
		texture = default_frame
