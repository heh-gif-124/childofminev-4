extends Node2D

@onready var sprite: Sprite2D = $Sprite2D



func _ready() -> void:
	$AnimationPlayer.play("new_animation")

func _destroy():
	queue_free()
