extends EnemyStateCatchable


@export var lunging_state: EnemyState

var is_animation_running = false


func enter(p_previous_state):
	super.enter(p_previous_state)

	is_animation_running = true
	await state_animations_scene.enter_state_attacking()
	is_animation_running = false


func exit():
	super.exit()


func attack():
	var target = parent.get_target_in_ranged_attack_reach()
	if target == null: return
	#or not target.has_method("on_took_damage"): return

	target.on_took_damage(parent)


func physics_process(_delta):
	var next_state = check_caught()

	if next_state != null \
	or is_animation_running:
		return next_state

	if parent.get_target_in_ranged_attack_reach() != null:
		next_state = lunging_state
	else:
		next_state = parent.get_initial_state()
	return next_state
