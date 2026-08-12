extends Node2D

@export var player: CharacterBody2D
@export var max_distance: float = 150.0  # Maximum pixels camera can drift from player

func _process(_delta):
	if not is_instance_valid(player):
		return

	var player_pos = player.global_position
	var mouse_pos = get_global_mouse_position()

	# Get offset vector towards mouse (halfway)
	var offset = (mouse_pos - player_pos) * 0.5

	# Clamp the offset length so it never exceeds max_distance
	offset = offset.limit_length(max_distance)

	global_position = player_pos + offset
