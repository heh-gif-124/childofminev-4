extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Interact_handler.interacted.connect(func():
		Globals.upgrade_chose.emit()
		)
