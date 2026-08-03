extends Node2D
@export var id := "HP"

# Called when the node enters the scene tree for the first time.

func _ready():
	# If your signal emits something (e.g. who interacted):
	$Interact_handler.interacted.connect(func(_user = null):
		var player = get_tree().get_first_node_in_group("Player")
		var staff = get_tree().get_first_node_in_group("staff")
		if id == "HP":
			if player:
				Globals.hp_mono += 1
				player.max_hp += 10
				player.hp += 10
				print("I TOOK IT ALREADY")
				print(player.max_hp)
				queue_free()
		elif id == "MP":
			if staff:
				Globals.mp_mono += 1
				staff.max_energy += 5
				staff.energy += 5
				print("I TOOK IT ALREADY")
				print(staff.max_energy)
				queue_free()
		elif id == "DMG":
			if staff:
				print("I TOOK IT ALREADY")
				queue_free()
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
