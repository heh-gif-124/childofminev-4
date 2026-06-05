extends Node
class_name following_handler
@onready var parent = get_parent()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	parent.global_position = lerp(parent.global_position,parent.target.global_position,0.45)
	parent.look_at(parent.get_global_mouse_position())
	aim_at_cursor()

func aim_at_cursor():
	# 1. Get the mouse position in the world
	var mouse_pos = parent.get_global_mouse_position()
	if mouse_pos.x > parent.global_position.x:
		parent.scale.y = 1
	else:
		parent.scale.y = -1
