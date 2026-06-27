extends CharacterBody2D

var hp = 10
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var player = get_parent().find_child("Player")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if $state_handler.current_state == "Walk":
		var dir_to_target = (player.global_position - global_position).normalized()
		velocity.x = dir_to_target.x * SPEED
	elif $state_handler.current_state == "Idle":
		velocity.x = 0
	
	
	move_and_slide()

func _process(delta: float) -> void:
	if hp <= 0:
		Globals.current_exp += 5
		Globals.teleporter_progress += 4
		print("I am TECHNICALLY dead.")
		queue_free()

func _Hurt(dmg):
	print("HIT")
	hp -= dmg
