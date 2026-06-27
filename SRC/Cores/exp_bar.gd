extends ProgressBar

var upgrading = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = Globals.current_exp


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = Globals.current_exp
	if Globals.current_exp >= 100:
		Globals.current_exp = 0
		Globals.upgrade_chose.emit()
