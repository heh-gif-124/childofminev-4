extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Interact_handler.interacted.connect(func():
		$Interact_handler.player.global_position = Vector2(0,-30)
		)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
