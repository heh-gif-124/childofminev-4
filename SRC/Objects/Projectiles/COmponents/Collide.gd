extends Area2D
class_name Collider_Handler
@onready var parent = get_parent()
@export var group_cant_be_hurt : String
@export var destroy_on_collide  = true
@export var knockback_force: float = 900.0
@export var base_damage = 12.0
@export var detect_blocking = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(func(body):
		var calculate = Globals.calculate_final_damage(base_damage,parent.p_crit,1.0)
		print(calculate)
		if body.has_method("_Hurt") and !body.is_in_group(group_cant_be_hurt):
			var d = calculate["final"]
			body._Hurt(d)
			if calculate["is_crit"] == true:
				if body.has_method("_stun"):
					body._stun(0.67)
			if body.has_method("apply_knockback"):
				var direction = (body.global_position - global_position).normalized()
				body.apply_knockback(direction * knockback_force)
			
		if destroy_on_collide == true:
			parent.queue_free()
		)
