extends CharacterBody2D

const SPEED = 200.0

@export var change_direction_time: float = 1.5

var wander_direction: Vector2 = Vector2.ZERO
var time_since_last_change: float = 0.0

func _ready() -> void:
	choose_random_direction()

func _physics_process(delta: float) -> void:
	# 1. Timer check
	time_since_last_change += delta
	if time_since_last_change >= change_direction_time:
		choose_random_direction()
	
	# 2. Apply the full 2D vector to velocity
	if wander_direction != Vector2.ZERO:
		velocity = wander_direction * SPEED
	else:
		# Smooth deceleration to a stop if idling
		velocity = velocity.move_toward(Vector2.ZERO, SPEED * 4 * delta)
		
	move_and_slide()

func choose_random_direction() -> void:
	var choice = randf()
	
	if choice < 0.8: # 80% chance to pick a random direction
		# randf_range for both axes creates a completely random vector angle
		var random_angle = randf_range(0, 2 * PI)
		wander_direction = Vector2.RIGHT.rotated(random_angle)
	else: # 20% chance to just pause and idle
		wander_direction = Vector2.ZERO
		
	time_since_last_change = 0.0
