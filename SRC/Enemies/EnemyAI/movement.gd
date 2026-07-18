extends CharacterBody2D

var hp = 10
@export var SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var player = get_parent().find_child("Player")

func _ready() -> void:
	pass
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if $state_handler.current_state == "Walk":
		$Marker2D.look_at($range_detector.player.global_position)
		var dir_to_target = (player.global_position - global_position).normalized()
		$Sprite2D.rotation += 15 * delta
		velocity.x = dir_to_target.x * SPEED
		if $range_detector.player.global_position >= global_position:
			$Sprite2D.flip_v = true
		elif $range_detector.player.global_position <= global_position:
			$Sprite2D.flip_v = false
	elif $state_handler.current_state == "Idle":
		velocity.x = 0
	
	
	move_and_slide()

func _process(delta: float) -> void:
	if hp <= 0:
		Globals.current_exp += 5 * Globals.expmult
		Globals.teleporter_progress += 4
		print("I am TECHNICALLY dead.")
		queue_free()

func _Hurt(dmg):
	print("HIT")
	hp -= dmg
