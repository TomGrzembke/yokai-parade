extends CharacterBody2D


@export var speed = 300.0
@export var jump_velocity = 600.0

var body_in_catch_radius = null


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()


func _on_catch_radius_body_entered(body: Node2D) -> void:
	body_in_catch_radius = body


func _on_catch_radius_body_exited(body: Node2D) -> void:
	if body == body_in_catch_radius:
		body_in_catch_radius = null


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("abililty") \
	and body_in_catch_radius != null \
	and body_in_catch_radius.has_method("caught"):
		body_in_catch_radius.caught()
