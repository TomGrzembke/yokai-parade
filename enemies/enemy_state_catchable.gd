class_name EnemyStateCatchable
extends EnemyState


@export var recovering_state: EnemyState


func check_caught():
	if parent != null \
	and parent.get_is_recovering():
		return recovering_state
