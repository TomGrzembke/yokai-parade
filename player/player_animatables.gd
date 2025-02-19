extends Node2D

@onready var player: CharacterBody2D = $".."
@onready var abilities: Node2D = $"../Abilities"
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var state_machine

func _ready():
	state_machine = animation_tree.get("parameters/playback")
	abilities.player_hits.connect(func(): state_machine.travel("hit"))
	abilities.used_ability.connect(func(): state_machine.travel("dash"))

	player.player_despawned.connect(func(): state_machine.travel("dying"))
	player.player_gets_pushed.connect(func(): state_machine.travel("got_hit"))


func hit():
	state_machine.travel("hit")


func _on_animation_finished(anim_name):
	if anim_name == "idling":
		state_machine.travel("idling2")
	elif anim_name == "idling2":
		state_machine.travel("idling")
