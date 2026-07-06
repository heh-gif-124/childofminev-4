extends CharacterBody2D
@export var start_anim = false
var hp = 100.0
var max_hp = 100.0
var speed = 350
var mouse_pos = get_global_mouse_position()

func _process(delta: float) -> void:
	
	mouse_pos = get_global_mouse_position()

func _input(event: InputEvent) -> void:
	if mouse_pos.x > global_position.x and is_on_floor():
		if Input.is_action_pressed("walk_right"):
			$AnimatedSprite2D.play("walk")
		elif Input.is_action_pressed("walk_left") and is_on_floor():
			$AnimatedSprite2D.play("walk_back")
		else:
			$AnimatedSprite2D.play("default")
	elif mouse_pos.x < global_position.x and is_on_floor():
		if Input.is_action_pressed("walk_right"):
			$AnimatedSprite2D.play("walk_back")
		elif Input.is_action_pressed("walk_left")  and is_on_floor():
			$AnimatedSprite2D.play("walk")
		else:
			$AnimatedSprite2D.play("default")
	
		
	
