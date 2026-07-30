# Global.gd
extends Node

## Spawns a fading ghost trail effect for any character
func spawn_ghost(source_node: Node2D, sprite: AnimatedSprite2D, duration: float = 0.25):
	if not source_node or not sprite:
		return
		
	var ghost = Sprite2D.new()
	
	# Copy the current frame texture and visual properties
	ghost.texture = sprite.sprite_frames.get_frame_texture(sprite.animation, sprite.frame)
	ghost.global_position = source_node.global_position
	ghost.flip_h = sprite.flip_h
	ghost.rotation = sprite.rotation
	ghost.scale = sprite.scale
	ghost.z_index = -1
	# Set the initial modulate to match the source node's color/visibility
	ghost.modulate = source_node.modulate
	
	# Add the ghost to the main scene tree root so it doesn't move with the player
	source_node.get_tree().current_scene.add_child(ghost)
	
	# Animate the fade out
	var t = source_node.create_tween()
	t.tween_property(ghost, "modulate:a", 0.0, duration)
	t.finished.connect(ghost.queue_free)
