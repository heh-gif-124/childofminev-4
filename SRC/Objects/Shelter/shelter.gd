extends Node2D

var shelter = Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Interact_handler.interacted.connect(func():
		shelter = get_parent().find_child("ShelterInside")
		$Interact_handler.player.global_position = shelter.global_position
		)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
