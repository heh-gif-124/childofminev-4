extends Button
@export var symbol : String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(func():
		Globals.AddCombo.emit(symbol)
		)
