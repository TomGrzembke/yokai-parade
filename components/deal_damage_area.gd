extends Area2D

var initial_scale

func _ready():
	initial_scale = scale.x


func on_deal_damage_area_entered(other):
	if other != null \
	and other.has_method("take_damage"):
		other.take_damage(self)


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("right"):
		scale.x = initial_scale
	elif Input.is_action_just_pressed("left"):
		scale.x = -initial_scale
