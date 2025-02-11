extends Camera2D

@export var offset_value : Vector2
@export var lerp_speed : float
@export var smooth_curve : Curve
var position_cache
var lerp_time = 0.0
var cached_direction= 1.0


func _ready():
	position_cache = position


func _physics_process(delta):
	look_offset(delta)


func look_offset(delta):
	var current_direction = sign(position.x - position_cache.x)

	if current_direction == 0:
		current_direction = cached_direction

	elif current_direction != cached_direction:
		cached_direction = current_direction
		offset_value.x = -offset_value.x
		lerp_time = 0.0

	lerp_time += delta
	offset = offset.lerp(offset_value, smooth_curve.sample(delta * lerp_speed * lerp_time))
	position_cache = position
