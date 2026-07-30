extends Node
class_name MoveHandler

@onready var parent = get_parent()

@export_category("Movement")
@export var launch_speed: float = 1800.0
@export var drag: float = 8.0          # Higher = slows down faster! Try 5.0 to 15.0.
@export var stop_threshold: float = 75.0 # How close to 0 speed before it explodes

@export_category("Effects")
@export var explosion_effect: PackedScene

var current_speed: float
signal explode()
func _ready() -> void:
	# Shoot out at full speed immediately
	current_speed = launch_speed

func _physics_process(delta: float) -> void:
	# Smoothly but aggressively drag the speed down to 0
	current_speed = lerp(current_speed, 0.0, drag * delta)
	
	# Move the parent
	parent.position += parent.transform.x * current_speed * delta
	
	# Once it has ground to a near-halt, trigger the explosion
	if current_speed <= stop_threshold:
		explode.emit()
		set_physics_process(false) # Disable process to prevent double explosions
