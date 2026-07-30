extends Control


func _ready() -> void:
	$HBoxContainer/Button.pressed.connect(func():
		Globals.scene_to_be_loaded = "res://MainLevels/Main.tscn"
		get_tree().change_scene_to_file("res://SRC/Cores/loading/LoadingScreen.tscn")
		)
