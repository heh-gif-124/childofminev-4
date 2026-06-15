extends Area2D
class_name range_detector
signal detected(entity)
@export var target_group := "Player"
@export var state_handler_used : state_handler
func _ready():
	pass

func _physics_process(delta: float) -> void:
	for i in get_overlapping_bodies():
		if i.is_in_group(target_group):
			if state_handler_used.states.size() > 1:
				state_handler_used.current_state = state_handler_used.states[1]
