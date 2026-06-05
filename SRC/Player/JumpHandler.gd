extends Node
class_name jump_handler
var parent
var extra_dash = 1
var is_dashing = false
var DASH_SPEED = 1100
var dash_velocity = Vector2.ZERO
@export var gravity := 1450.0
@onready var sprite = $"../AnimatedSprite2D"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	$"../Ghost_Timer".paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not parent.is_on_floor() and is_dashing == false:
		parent.velocity.y += gravity * delta
	if is_dashing:
		# Override normal movement and apply the fixed dash speed
		parent.velocity = dash_velocity
	if parent.is_on_floor():
		extra_dash = 1
	if Input.is_action_pressed("ui_accept") and parent.is_on_floor():
		parent.velocity.y -= 450
	elif Input.is_action_just_pressed("ui_accept") and not parent.is_on_floor() and extra_dash > 0:
		_startdash()
	parent.move_and_slide()
	
func _startdash():
	if is_dashing: 
		return # Prevents spamming the dash mid-dash
	parent.velocity.y = 0
	is_dashing = true

	$"../Ghost_Timer".paused = false
	extra_dash = 0

	# Calculate direction towards mouse
	var dash_dir = (parent.get_global_mouse_position() - parent.global_position).normalized()
	# FIX: Check if looking left (mouse X is less than player X)
	# Store the velocity so it stays consistent during the dash
	dash_velocity = dash_dir * DASH_SPEED
	
	# Create a temporary timer that lasts for DASH_DURATION
	await parent.get_tree().create_timer(0.2).timeout
	
	# This code runs AFTER the timer finishes
	_end_dash()

func _end_dash():
	is_dashing = false
	$"../Ghost_Timer".paused = true
	parent.rotation = 0
	sprite.rotation = 0
