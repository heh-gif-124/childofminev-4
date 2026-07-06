extends Node
class_name glide
var duplicate_possible = false
func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if Input.is_action_pressed("look_down") and not get_parent().is_on_floor():
		get_parent().velocity.y = 5
