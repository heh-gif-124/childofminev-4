extends CharacterBody2D
var p_crit = 5
var p_crit_dmg = 20
var hp = 30
@export var SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var player = get_parent().find_child("Player")
var knockback_velocity: Vector2 = Vector2.ZERO
@export var knockback_friction: float = 10.0
var sprite : Sprite2D
var dash_cooldown_timer: float = 0.0
# Dash related stuff, gruh
@export var dash_cooldown: float = 1.5
@export var attack_range: float = 150.0       # Distance to trigger the charge
@export var charge_duration: float = 0.8      # How long it winds up (stops)
@export var dash_speed: float = 800.0         # How fast it lunges at the player
@export var dash_duration: float = 0.3        # How long the lunge lasts

var attack_timer: float = 0.0
var dash_timer: float = 0.0
var charge_direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	sprite = $Sprite2D
	$ProgressBar.max_value = hp

func _physics_process(delta: float) -> void:
	$ProgressBar.value = hp
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta
		velocity.x = 0
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# 1. State: Walk
	if $state_handler.current_state == "Walk":
		$Marker2D.look_at($range_detector.player.global_position)
		var dir_to_target = (player.global_position - global_position).normalized()
		velocity.x = dir_to_target.x * SPEED
		
		# Flip logic
		if $range_detector.player.global_position.x >= global_position.x:
			$Sprite2D.flip_h = false
		elif $range_detector.player.global_position.x <= global_position.x:
			$Sprite2D.flip_h = true
			
		# Check if close enough to player to trigger the charge
		if global_position.distance_to(player.global_position) <= attack_range:
			start_charge()

	# 2. State: Idle
	elif $state_handler.current_state == "Idle":
		velocity.x = 0
		$Sprite2D.texture = load("res://Sprites/Sprites/Enemies/Lowerling/LowerlingIdle.png")
	# The Charging state (fuck you)
	elif $state_handler.current_state == "Charge" and dash_cooldown_timer <= 0:
		$Sprite2D.texture = load("res://Sprites/Sprites/Enemies/Lowerling/Lowering_charge.png")
		# Flip logic
		if $range_detector.player.global_position.x >= global_position.x:
			$Sprite2D.flip_h = false
		elif $range_detector.player.global_position.x <= global_position.x:
			$Sprite2D.flip_h = true
		attack_timer -= delta
		if attack_timer <= 0:
			start_dash()

	# 4. NEW STATE: Dash (The actual lunging strike)
	elif $state_handler.current_state == "Dash":
		$Sprite2D.texture = load("res://Sprites/Sprites/Enemies/Lowerling/Lowering_attack.png")
		velocity.x = charge_direction.x * dash_speed
		$Collider_Handler/CollisionShape2D.disabled = false
		dash_timer -= delta
		if dash_timer <= 0:
			# Start the cooldown timer when the dash ends
			dash_cooldown_timer = dash_cooldown
		
			# Return to walking after the dash ends
			$state_handler.current_state = "Walk"
			$Sprite2D.texture = load("res://Sprites/Sprites/Enemies/Lowerling/LowerlingIdle.png")
			$Collider_Handler/CollisionShape2D.disabled = true
	
	move_and_slide()

func start_charge():
	$state_handler.current_state = "Charge"
	attack_timer = charge_duration
	
	# Lock in the direction of the player at the *moment* of charging
	charge_direction = (player.global_position - global_position).normalized()
	velocity.x = -80 * charge_direction.x

func start_dash():
	$state_handler.current_state = "Dash"
	dash_timer = dash_duration
	charge_direction = (player.global_position - global_position).normalized()


func _process(delta: float) -> void:
	
	if hp <= 0:
		Globals.current_exp += 5 * Globals.expmult
		Globals.teleporter_progress += 4
		print("I am TECHNICALLY dead.")
		queue_free()

func _Hurt(dmg):
	_play_hurt_vfx()
	print("HIT")
	hp -= dmg

func _play_hurt_vfx() -> void:
	if not sprite:
		return
	
	# Create a tween for the flash effect
	var flash_tween = create_tween()
	flash_tween.tween_property(sprite, "modulate", Color.RED, 0.05)
	flash_tween.tween_property(sprite, "modulate", Color.WHITE, 0.1)
	
