extends CharacterBody2D



@export var start_anim : bool = false
@export var parry_window : Timer
@export var popoPos = Vector2()
var mouse_pos := get_global_mouse_position()
var has_shield : bool = false
var block_damage_negator : int = 4
var block_stamina : int = 50
var is_blocking : bool= false
var parrying : bool = false

func _ready() -> void:
	parry_window.timeout.connect(_expire_window)

func _process(delta: float) -> void:
	popoPos.x = global_position.x
	popoPos.y = global_position.y
	mouse_pos = get_global_mouse_position()

func _input(event: InputEvent) -> void:
	if mouse_pos.x > global_position.x:
		if Input.is_action_pressed("walk_right"):
			$AnimatedSprite2D.play("walk")
		elif Input.is_action_pressed("walk_left"):
			$AnimatedSprite2D.play("walk_back")
		else:
			$AnimatedSprite2D.play("default")
	elif mouse_pos.x < global_position.x  :
		if Input.is_action_pressed("walk_right"):
			$AnimatedSprite2D.play("walk_back")
		elif Input.is_action_pressed("walk_left"):
			$AnimatedSprite2D.play("walk")
		else:
			$AnimatedSprite2D.play("default")
	if Input.is_action_pressed("Parry"):
		is_blocking = true
		
		
		print("IMBLOCKING")
	if Input.is_action_just_pressed("Parry"):
		parry_window.start(0)
		parrying = true
		$MainPlayerAnimationHandler.play("Block_Start")
		
	elif Input.is_action_just_released("Parry"):
		$MainPlayerAnimationHandler.play("Block_end")
		is_blocking = false
	

func _Hurt(dmg):
	if has_shield == true:
		pass
	elif parrying == true:
		pass
		parry_window.start(0)
		Globals._stop_time(0.6,0)
		print("Parried!")
	elif is_blocking == true:
		
		print("oh no i got blocked")
		PlayerStatsManager.hp -= dmg / block_damage_negator
		block_stamina -= 10
		print(block_stamina)
	else:
		PlayerStatsManager.hp -= dmg

func _expire_window() -> void:
	parrying = false
	print("Parry expired")
