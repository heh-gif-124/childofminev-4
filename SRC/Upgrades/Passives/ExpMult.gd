extends Node
class_name exp_mult

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.expmult += 0.45
	queue_free()
