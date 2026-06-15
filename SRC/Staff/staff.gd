extends Node2D
#This script mostly only handles the stuff that the staff needs (ex: player)
#This is ALSO where the main stuff is handled
@export var target : Node2D
@export var energy = 10
@export var max_energy = 10
@onready var crit = Globals.base_crit_rate
@onready var crit_dmg = Globals.base_crit_dmg

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack") and !(energy <= 0):
		energy -= 1
		$firing_handler._fire()
	if Input.is_action_just_pressed("reload"):
		$AnimationPlayer.play("Reload")
		energy = max_energy
