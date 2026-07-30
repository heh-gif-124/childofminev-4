extends Sprite2D
@export var x_lock = false
@export var y_lock = false
@export var target : Node2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if x_lock == false:
		global_position.x = target.global_position.x
	if y_lock == false:
		global_position.y = target.global_position.y
