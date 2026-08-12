extends CharacterBody2D

var p_crit = 0
var p_crit_dmg = 20
var dmg = 8
var hp = 30
@export var SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var player = get_parent().find_child("Player")
var knockback_velocity: Vector2 = Vector2.ZERO
@export var knockback_friction: float = 10.0
var sprite : Sprite2D

# Dash & Attack Parameters
@export var dash_cooldown: float = 1.5
@export var attack_range: float = 150.0       # Distance to trigger charge
@export var charge_duration: float = 0.8      # Windup time
@export var dash_speed: float = 800.0         # Lunge speed
@export var dash_duration: float = 0.3        # Duration of lunge

# NEW STRAFE PARAMETERS
@export var strafe_speed: float = 180.0       # Speed while retreating/strafing
@export var strafe_distance: float = 220.0     # Ideal distance to back away to

var dash_cooldown_timer: float = 0.0
var attack_timer: float = 0.0
var dash_timer: float = 0.0
var charge_direction: Vector2 = Vector2.ZERO
var strafe_dir: float = -1.0                  # Backs away by default

func _ready() -> void:
	sprite = $Sprite2D
	$ProgressBar.max_value = hp
	$MainAnimation.play("Float")

func _physics_process(delta: float) -> void:
	$ProgressBar.value = hp

	# Gravity apply
	if not is_on_floor():
		velocity += get_gravity() * delta

	# --- STATE MACHINE ---

	# 1. State: Walk (chasing target)
	if $state_handler.current_state == "Walk":
		$Marker2D.look_at($range_detector.player.global_position)
		var dir_to_target = (player.global_position - global_position).normalized()
		velocity.x = dir_to_target.x * SPEED

		_update_flip()

		# Trigger attack if close enough
		if global_position.distance_to(player.global_position) <= attack_range:
			start_charge()

	# 2. State: Idle
	elif $state_handler.current_state == "Idle":
		velocity.x = move_toward(velocity.x, 0, 800 * delta)
		$Sprite2D.texture = load("res://Sprites/Sprites/Enemies/Lowerling/LowerlingIdle.png")

	# 3. State: Charge (Wind-up)
	elif $state_handler.current_state == "Charge":
		$Sprite2D.texture = load("res://Sprites/Sprites/Enemies/Lowerling/Lowering_charge.png")
		_update_flip()

		attack_timer -= delta
		if attack_timer <= 0:
			start_dash()

	# 4. State: Dash (Lunge)
	elif $state_handler.current_state == "Dash":
		$Sprite2D.texture = load("res://Sprites/Sprites/Enemies/Lowerling/Lowering_attack.png")
		velocity.x = charge_direction.x * dash_speed
		$Collider_Handler/CollisionShape2D.disabled = false

		dash_timer -= delta
		if dash_timer <= 0:
			end_dash_and_start_strafe()

	# 5. NEW State: Strafe (Back off during attack cooldown)
	elif $state_handler.current_state == "Strafe":
		$Sprite2D.texture = load("res://Sprites/Sprites/Enemies/Lowerling/LowerlingIdle.png")
		_update_flip()

		dash_cooldown_timer -= delta

		# Calculate direction relative to player
		var dist_to_player = global_position.distance_to(player.global_position)
		var dir_away = (global_position - player.global_position).normalized().x

		# Back away if too close, or randomly hover around strafe distance
		if dist_to_player < strafe_distance:
			velocity.x = sign(dir_away) * strafe_speed
		else:
			velocity.x = strafe_dir * (strafe_speed * 0.5)

		# When cooldown ends, return to chasing
		if dash_cooldown_timer <= 0:
			$state_handler.current_state = "Walk"

	move_and_slide()

# --- STATE TRANSITIONS & HELPERS ---

func start_charge():
	$state_handler.current_state = "Charge"
	attack_timer = charge_duration
	charge_direction = (player.global_position - global_position).normalized()
	velocity.x = -randf_range(20, 80) * charge_direction.x # Slight recoil windup

func start_dash():
	$state_handler.current_state = "Dash"
	dash_timer = dash_duration
	charge_direction = (player.global_position - global_position).normalized()

func end_dash_and_start_strafe():
	dash_cooldown_timer = dash_cooldown
	$state_handler.current_state = "Strafe"
	$Collider_Handler/CollisionShape2D.disabled = true

	# Pick a random strafe direction modifier (-1 or 1) for variety
	strafe_dir = 1.0 if randf() > 0.5 else -1.0

func _update_flip():
	if $range_detector.player:
		$Sprite2D.flip_h = $range_detector.player.global_position.x < global_position.x

func _process(delta: float) -> void:
	if hp <= 0:
		Globals.current_exp += 5 * PlayerStatsManager.exp_multi
		Globals.teleporter_progress += 4
		queue_free()

func _Hurt(damage: float):
	_play_hurt_vfx()
	hp -= damage

func _play_hurt_vfx() -> void:
	if not sprite:
		return
	var flash_tween = create_tween()
	flash_tween.tween_property(sprite, "modulate", Color.RED, 0.05)
	flash_tween.tween_property(sprite, "modulate", Color.WHITE, 0.1)
