extends Node2D


var target_in_ranged_attack_reach


func _ready():
	if get_node_or_null("DealDamageArea") == null:
		assert("Ranged attack component at %s is missing DealDamageArea child." % get_path())

	$DealDamageArea.deal_damage_area_entered.connect(on_deal_damage_area_entered)
	$DealDamageArea.deal_damage_area_exited.connect(on_deal_damage_area_exited)


func _physics_process(_delta):
	pass # TODO: Update obstruction raycast target and check every physics frame


func get_target_in_ranged_attack_reach():
	return target_in_ranged_attack_reach


func clear_target_in_ranged_attack_reach():
	target_in_ranged_attack_reach = null


func is_target_obstructed(target):
	%ObstructionRayCast.target_position = to_local(target.global_position)
	return %ObstructionRayCast.is_colliding()


func check_target_in_ranged_attack_reach(target):
	if is_target_obstructed(target):
		return

	target_in_ranged_attack_reach = $DealDamageArea.get_damageable_subject(target)


func on_deal_damage_area_entered(target):
	if target == null: return

	%ObstructionRayCast.enabled = true
	%ObstructionRayCast.add_exception(target)

	check_target_in_ranged_attack_reach(target)

	target_in_ranged_attack_reach = get_target_in_ranged_attack_reach()


func on_deal_damage_area_exited(_target):
	%ObstructionRayCast.clear_exceptions()
	%ObstructionRayCast.enabled = false

	clear_target_in_ranged_attack_reach()
