extends Camera2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("walk_left"):
		rotation = 0.01
	elif Input.is_action_pressed("walk_right"):
		rotation = -0.01
	else:
		rotation = 0
