extends Area2D
class_name Collider_Handler
@onready var parent = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(func(body):
		parent.queue_free()
		)
