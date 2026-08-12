extends Node
class_name movement_handler
@export var speed = 400.0
@export var sprite : AnimatedSprite2D
@export var acceleration: float = 1200.0  # How fast they speed up
@export var friction: float = 1500.0      # How fast they slide to a stop
var parent
var slowfall: bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	slowfall = parent.velocity.y > 0 and Input.is_action_pressed("jump")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir = Input.get_axis("walk_left","walk_right")
	
	if dir != 0:
		# Smoothly accelerate towards maximum speed
		if parent.is_blocking == true:
			parent.velocity.x = move_toward(parent.velocity.x, dir * PlayerStatsManager.player_speed, acceleration * delta)/1.25
		elif  parent.is_blocking == false:
			parent.velocity.x = move_toward(parent.velocity.x, dir * PlayerStatsManager.player_speed, acceleration * delta)
	else:
		# Smoothly slow down to 0 when no buttons are pressed
		parent.velocity.x = move_toward(parent.velocity.x, 0, friction * delta)
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
