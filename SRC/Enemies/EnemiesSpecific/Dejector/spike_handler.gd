extends Node2D
var rotating = true

func _ready() -> void:
	get_parent().global_position.y = -350
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	if rotating == true:
		rotation += 1 * delta
	$"../Sprite2D".rotation -= 2 * delta
