extends Area2D


func on_body_entered(other):
	if other == null \
	or not other.has_method("on_goal_reached"):
		return

	other.on_goal_reached()
	%AnimationPlayer.play("celebrate")
	set_deferred("monitoring", false)
