extends Area2D

var player : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x = player.global_position.x
	for i in get_overlapping_bodies():
		if i.is_in_group("Player"):
			i.global_position = Vector2(0,-49)
