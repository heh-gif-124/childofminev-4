extends Node
class_name exp_mult

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerStatsManager.exp_multi += 0.45
	queue_free()
