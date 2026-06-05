extends Node
class_name move_handler
@onready var parent = get_parent()
@export var speed = 1800
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	parent.position += parent.transform.x * speed * delta
