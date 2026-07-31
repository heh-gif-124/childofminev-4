extends Node2D


# Called when the node enters the scene tree for the first time.

func _ready():
	$Interact_handler.interacted.connect(func():
		print("fatfuck")
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
