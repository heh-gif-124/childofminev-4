extends Timer
class_name despawn_handler


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.wait_time = 300
	self.autostart = true
	self.timeout.connect(func():
		get_parent().queue_free()
		)
