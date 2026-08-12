extends Node2D

var p_crit : float
var p_crit_dmg : float
var dmg : float
func _ready() -> void:
	$move_handler.explode.connect(func():
		queue_free()
		)
