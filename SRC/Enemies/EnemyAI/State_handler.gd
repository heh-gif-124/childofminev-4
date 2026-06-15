extends Node
class_name state_handler
@export var states := ["Idle"] # A note is that, the idle state MUST be the first
var current_state
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_state = states[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
