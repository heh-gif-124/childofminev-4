extends Node2D

var price = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	price = randf_range(12,30)
	$Interact_handler.interacted.connect(func():
		if Globals.moneh >= price:
			pass
		)
