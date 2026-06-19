extends Area2D
class_name Collider_Handler
@onready var parent = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(func(body):
		var calculate = Globals.calculate_final_damage(3.5,parent.p_crit,parent.p_crit_dmg)
		print(calculate)
		if body.has_method("_Hurt"):
			body._Hurt(calculate["final"])
		parent.queue_free()
		)
