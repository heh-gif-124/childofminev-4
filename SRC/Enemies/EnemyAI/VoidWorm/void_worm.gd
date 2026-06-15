extends Node2D

@onready var state_handling = $state_handler
@export var Bullet : PackedScene
@onready var head = $Head/Marker2D
var hp = 20.0
func _ready():
	$Timer.paused = true
	$Timer.timeout.connect(func():
		shoot()
		)
func shoot():
	var b = Bullet.instantiate()
	get_parent().add_child(b)
	b.transform = head.global_transform

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if state_handling.current_state == state_handling.states[1]:
		$Timer.paused = false
	if hp <= 0:
		queue_free()

func _Hurt(dmg):
	hp -= dmg
