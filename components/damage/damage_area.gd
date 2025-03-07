extends Area2D


@export var subject: Node2D


func get_damage_subject():
	if subject != null:
		return subject

	return get_parent()


func get_damageable_subject(target):
	if not target.has_method("get_damage_subject"):
		return null

	var target_subject = target.get_damage_subject()

	if target_subject == null \
	or not target_subject.has_method("on_took_damage"):
		return null

	return target_subject
