extends Node2D

var p_crit
var p_crit_dmg

func _ready() -> void:
	$move_handler.explode.connect(func():
		$AnimationPlayer.play("explode")
		)
