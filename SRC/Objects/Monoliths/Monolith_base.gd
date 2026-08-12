extends Node2D
@export var id : String= "HP"

# Called when the node enters the scene tree for the first time.

func _ready():
	# If your signal emits something (e.g. who interacted):
	$Interact_handler.interacted.connect(func(_user = null):
		var player = get_tree().get_first_node_in_group("Player")
		var staff = get_tree().get_first_node_in_group("staff")
		if id == "HP":
			if player:
				Globals.hp_mono += 1
				PlayerStatsManager.max_hp += 10
				PlayerStatsManager.hp += 10
				print("I TOOK IT ALREADY")
				print(PlayerStatsManager.max_hp)
				queue_free()
		elif id == "MP":
			if staff:
				Globals.mp_mono += 1
				PlayerStatsManager.max_energy += 5
				PlayerStatsManager.energy += 5
				print("I TOOK IT ALREADY")
				print(PlayerStatsManager.max_energy)
				queue_free()
		elif id == "DMG":
			if staff:
				PlayerStatsManager.damage += 2
				print(PlayerStatsManager.damage)
				print("I TOOK IT ALREADY")
				queue_free()
		elif id == "UNI":
			if player and staff:
				Globals.hp_mono += 1
				Globals.mp_mono += 1
				Globals.dmg_mono += 1
				player.max_hp += 5
				player.hp += 5
				staff.max_energy += 2
				staff.energy += 2
				staff.dmg += 1
				print("I TOOK IT ALREADY")
				print(player.max_hp)
				queue_free()
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
