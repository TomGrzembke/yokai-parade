extends EnemyState


@export_category("Components")
@export var attack_melee_component: Node2D
@export var take_damage_component: Node2D

var is_animation_running = true


func enter(p_previous_state):
	is_animation_running = true

	super.enter(p_previous_state)

	attack_melee_component.set_deal_damage_active(false)
	await visualisation_component.enter_state_recovering()

	is_animation_running = false


func physics_process(_delta):
	if is_animation_running:
		return

	return context.get_initial_state()


func exit():
	super.exit()

	take_damage_component.set_did_take_damage(false)
	attack_melee_component.set_deal_damage_active(true)
