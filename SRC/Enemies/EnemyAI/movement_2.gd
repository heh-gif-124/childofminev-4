extends CharacterBody2D
var p_crit = 5
var p_crit_dmg = 20
var dmg = 8
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

