extends skill
class_name heal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pattern = ["sq","tr","tr"]
	Globals.SkillUse.connect(func(id):
		get_parent().hp += 15
		)

func _activate():
	pass
