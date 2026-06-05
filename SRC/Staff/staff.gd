extends Node2D
#This script mostly only handles the stuff that the staff needs (ex: player)
#This is ALSO where the main stuff is handled
@export var target : Node2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		$firing_handler._fire()
