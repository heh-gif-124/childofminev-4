extends Control
var cards
@onready var upgrade_folder = Globals.load_folder_children("res://SRC/Cores/Cards/")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.upgrade_chose.connect(func():
		visible = true
		_upgrade()
		)
func _upgrade():
	print("IK EPP")
	if upgrade_folder.is_empty():
		print("No upgrades found in the folder")
		return
	var available_upgrades = upgrade_folder.duplicate()
	for i in 3:
		if available_upgrades.is_empty():
			break
			
		var upg = available_upgrades.pick_random()
		
		available_upgrades.erase(upg)
		
		#Instantiate and add it to your UI container
		var upgd = upg.instantiate()
		$CardContainer.add_child.call_deferred(upgd)
