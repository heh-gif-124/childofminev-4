extends Node
class_name explosion
var pattern = ["sq","sq","sq"]
@onready var shield_scene = preload("res://SRC/Cores/vfx/Shield/Shield.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _activate():
	
	get_parent().get_parent().has_shield = true
	
