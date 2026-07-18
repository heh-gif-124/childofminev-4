extends Timer
class_name Green_Regen
var player_sub : CharacterBody2D
#WHYAMISOGREEN
func _ready() -> void:
	self.wait_time = 3
	self.autostart = true
	await get_tree().process_frame
	player_sub = get_parent().player

	player_sub.modulate = Color(0,255,0)

	self.timeout.connect(func():
		player_sub.hp += 5
	)
