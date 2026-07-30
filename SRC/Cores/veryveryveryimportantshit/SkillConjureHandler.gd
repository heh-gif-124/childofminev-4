extends Node
class_name SkillConjureManager

@onready var player = get_parent()
var skill_list 
func _ready() -> void:
	skill_list = get_children()
	Globals.SkillUse.connect(func(id):
		for i in skill_list:
			if id == i.pattern:
				i._activate()
		)
		
	


	
