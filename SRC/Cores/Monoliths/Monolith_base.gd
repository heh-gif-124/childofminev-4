extends Node2D


# Called when the node enters the scene tree for the first time.

func _ready():
	# If your signal emits something (e.g. who interacted):
	$Interact_handler.interacted.connect(func(_user = null):
		var player = get_tree().get_first_node_in_group("Player")
		if player:
			player.max_hp += 10
			player.hp += 10
			print("I TOOK IT ALREADY")
			print(player.max_hp)
			queue_free()
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
