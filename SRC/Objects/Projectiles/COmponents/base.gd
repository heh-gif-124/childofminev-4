extends Node2D

var p_crit = 5
var p_crit_dmg = 20

func _ready() -> void:
	$move_handler.explode.connect(func():
		queue_free()
		)
