extends Node2D


func is_on_cliff():
	return \
	not %RightGroundDetectionRayCast.is_colliding() \
	or not %LeftGroundDetectionRayCast.is_colliding()
