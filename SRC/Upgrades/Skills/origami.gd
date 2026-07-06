extends Node
class_name origami
var pattern = ["sq","tr","tr"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _activate():
	get_parent().get_parent().hp += 15
	get_tree().get_first_node_in_group("staff").energy -= 2
	print("i work")
