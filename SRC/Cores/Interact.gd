extends Area2D
class_name Interact_handler

# This signal fires when the player successfully interacts with this object
signal interacted

# Reference to the text prompt node (we'll create this in Step 2)
@onready var prompt_text: Label = $Label

var player_in_range: bool = false

func _ready() -> void:
	# Hide the text prompt at the start
	prompt_text.visible = false
	
	# Connect Godot's built-in Area2D signals to our functions
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _unhandled_input(event: InputEvent) -> void:
	# Check if the player is nearby and pressed your interact key
	# Replace "ui_accept" with your custom action (like "interact") in Project Settings if you want
	if player_in_range and event.is_action_pressed("interact"):
		# Trigger the signal!
		interacted.emit()
		print("Player interacted with: ", get_parent().name)


func _on_body_entered(body: Node2D) -> void:
	# Make sure the thing entering the area is actually the player
	if body.is_in_group("Player"):
		player_in_range = true
		prompt_text.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_range = false
		prompt_text.visible = false
