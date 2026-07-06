extends Node

const PILLAR_2D_SCENE = preload("res://SRC/Cores/vfx/Pillar/PillarScene.tscn")

func spawn_light_pillar_2d(target_position: Vector2) -> void:
	var pillar = PILLAR_2D_SCENE.instantiate()
	# Set the position safely while it's still just data in memory
	pillar.global_position = target_position 
	
	# Now defer the actual scene tree insertion
	get_tree().current_scene.add_child.call_deferred(pillar)
