extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("Intro")

func _change():
	get_tree().change_scene_to_file("res://MainLevels/Menu.tscn")
