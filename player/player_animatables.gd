extends Node2D

@export var idle_animation_probability : Dictionary = {"idling" : 80, "idling2": 15, "idling3": 5}
@onready var player: CharacterBody2D = $".."
@onready var abilities: Node2D = $"../Abilities"
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var state_machine

func _ready():
	state_machine = animation_tree.get("parameters/playback")
	abilities.player_hits.connect(func(): state_machine.start("hit"))
	abilities.used_ability.connect(func(): state_machine.start("dash"))

	player.player_despawned.connect(func(): state_machine.start("dying"))
	player.player_gets_pushed.connect(func(): state_machine.start("got_hit"))


func _on_animation_finished(anim_name):
	different_idles(anim_name)


func different_idles(anim_name):
	if !anim_name in idle_animation_probability: return
	if anim_name == "idling3": return

	var total_weight = 0
	for key in idle_animation_probability.values():
		total_weight += key

	var random_value = randf_range(0, total_weight)
	var cumulative_weight = 0

	for animation_name in idle_animation_probability.keys():
		cumulative_weight += idle_animation_probability[animation_name]

		if random_value > cumulative_weight: continue
		state_machine.start(animation_name)
		return
