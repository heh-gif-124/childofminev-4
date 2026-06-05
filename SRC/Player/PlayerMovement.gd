extends Node
class_name movement_handler
@export var speed = 400.0
@onready var sprite = $"../AnimatedSprite2D"
var parent
var slowfall: bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	slowfall = parent.velocity.y > 0 and Input.is_action_pressed("jump")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir = Input.get_axis("walk_left","walk_right")
	parent.velocity.x = speed * dir
	
	aim_at_cursor()
	
func aim_at_cursor():
	# 1. Get the mouse position in the world
	var mouse_pos = parent.get_global_mouse_position()
	if mouse_pos.x > parent.global_position.x:
		sprite.scale.x = 1 # Facing Right
	else:
		sprite.scale.x = -1  # Facing Left


func _on_ghost_timer_timeout() -> void:
	GhostManager.spawn_ghost(parent, sprite)
