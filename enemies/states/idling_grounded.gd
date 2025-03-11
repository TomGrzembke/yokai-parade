extends EnemyState


@export_category("Enemy States")
@export var attacking_melee_enemy_state: EnemyState
@export var lunging_enemy_state: EnemyState
@export var recovering_state: EnemyState

@export_category("Components")
@export var target_direction_component: Node2D
@export var attack_melee_component: Node2D
@export var attack_ranged_component: Node2D
@export var take_damage_component: Node2D


func enter(p_previous_state):
	super.enter(p_previous_state)

	visualisation_component.enter_state_idling()


func physics_process(delta):
	handle_gravity(delta)
	context.move_and_slide()

	var target_direction = target_direction_component.get_target_direction()
	var new_direction = visualisation_component.get_facing_direction()

	if target_direction != null:
		new_direction = Vector2(target_direction.x, 0.0).normalized()
		visualisation_component.set_facing_direction(new_direction)
	else:
		new_direction = visualisation_component.get_facing_direction()

	if take_damage_component.get_did_take_damage():
		return recovering_state

	var next_state

	if attack_melee_component.get_target_in_range() != null:
		next_state = attacking_melee_enemy_state
	elif attack_ranged_component.get_target_in_visible_range() != null:
		next_state = lunging_enemy_state

	return next_state


func handle_gravity(delta):
	if not context.is_on_floor():
		context.velocity += context.get_gravity() * delta
