extends CharacterBody2D
@export var start_anim = false
var hp = 100.0
var max_hp = 100.0
var speed = 350
var mouse_pos = get_global_mouse_position()
var has_shield = false
var block_damage_negator = 4
var block_stamina = 50
var is_blocking = false
func _process(delta: float) -> void:
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
		$MainPlayerAnimationHandler.play("Block_Start")
		
	elif Input.is_action_just_released("Parry"):
		$MainPlayerAnimationHandler.play("Block_end")
		is_blocking = false
	

func _Hurt(dmg):
	if has_shield == true:
		pass
	elif is_blocking == true:
		print("oh shit i got blocked")
		hp -= dmg / block_damage_negator
		block_stamina -= 10
		print(block_stamina)
	else:
		hp -= dmg
