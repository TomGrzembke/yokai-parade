extends EnemyState


@export_category("Enemy States")
@export var recovering_state: EnemyState

@export_category("Components")
@export var attack_ranged_component: Node2D
@export var take_damage_component: Node2D

var is_animation_running = true


func enter(p_previous_state):
	is_animation_running = true

	super.enter(p_previous_state)

	await visualisation_component.enter_state_attacking()
	is_animation_running = false


func physics_process(_delta):
	if take_damage_component.get_did_take_damage():
		return recovering_state

	if is_animation_running:
		return null

	return context.get_initial_state()


func attack():
	var target = attack_ranged_component.get_target_in_visible_range()
	if target == null \
	or not target.has_method("on_took_damage"): return

	target.on_took_damage(context)
