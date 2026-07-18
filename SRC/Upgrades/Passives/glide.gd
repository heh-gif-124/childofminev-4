extends Node
class_name glide
var duplicate_possible = false
var player_sub : CharacterBody2D
func _ready() -> void:
	await get_tree().process_frame
	player_sub = get_parent().player


func _process(delta: float) -> void:
	if Input.is_action_pressed("look_down") and not player_sub.is_on_floor():
		player_sub.velocity.y = 5
