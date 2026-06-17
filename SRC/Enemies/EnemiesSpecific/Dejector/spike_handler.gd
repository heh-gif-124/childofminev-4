extends Node2D
var rotating = true

func _ready() -> void:
	get_parent().global_position.y = -150
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if rotating == true:
		rotation += 1 * delta
	$"../Sprite2D".rotation -= 2 * delta

func _raycast_1_detect():
	if $Node2D/RayCast2D.is_colliding():
		rotating = false
	else:
		rotating = true
func _raycast_2_detect():
	if $Node2D2/RayCast2D2.is_colliding():
		rotating = false
	else:
		rotating = true
