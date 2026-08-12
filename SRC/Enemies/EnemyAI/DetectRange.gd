extends Area2D
class_name range_detector
signal detected(entity)
var player = Node2D
@export var target_group : String = "Player"
@export var state_handler_used : state_handler
@export var agro_dissapear : bool = true
func _ready() -> void:
	body_entered.connect(func(body):
		if body.is_in_group("Player"):
			player = body
			state_handler_used.current_state = state_handler_used.states[1]
		)
	body_exited.connect(func(body):
		if body.is_in_group("Player") and agro_dissapear == true:
			state_handler_used.current_state = state_handler_used.states[0]
		)
