extends Node2D
@export var id := "HP"

# Called when the node enters the scene tree for the first time.

func _ready():
	$Interact_handler.interacted.connect(func():
		if id == "HP":
			var d = get_tree().get_first_node_in_group("Player")
			d.max_hp += 10
		elif id == "MP":
			var d = get_tree().get_first_node_in_group("staff")
			d.max_energy += 3
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
