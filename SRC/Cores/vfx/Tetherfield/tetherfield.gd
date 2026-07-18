extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in $Area2D.get_overlapping_bodies():
		if i.is_in_group("Enemy"):
			i.SPEED = i.SPEED / 1.5
