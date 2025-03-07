extends "res://components/damage/damage_area.gd"


signal deal_damage_area_entered(target)
signal deal_damage_area_exited(target)


func check_is_damage_subject(target):
	if not target.has_method("get_damage_subject"):
		return null

	return target.get_damage_subject()


func is_collision_between_damage_subjects(subject1, subject2):
	return subject1 != null \
	and subject2 != null


func is_collision_between_distinct_subjects(subject1, subject2):
	return subject1 != subject2


func is_valid_subject_collision(subject1, subject2):
	return is_collision_between_damage_subjects(subject1, subject2) \
	and is_collision_between_distinct_subjects(subject1, subject2)


func on_deal_damage_area_entered(source):
	if source == null: return

	var subject = check_is_damage_subject(self)
	var source_subject = check_is_damage_subject(source)

	if not is_valid_subject_collision(subject, source_subject): return

	if source.has_method("deal_damage_area_entered_take_damage_area"):
		deal_damage_area_entered.emit(source)
		source.deal_damage_area_entered_take_damage_area(self)


func on_deal_damage_area_exited(source):
	if source == null: return

	var subject = check_is_damage_subject(self)
	var source_subject = check_is_damage_subject(source)

	if not is_valid_subject_collision(subject, source_subject): return

	if source.has_method("deal_damage_area_exited_take_damage_area"):
		deal_damage_area_exited.emit(source)
		source.deal_damage_area_exited_take_damage_area(self)
