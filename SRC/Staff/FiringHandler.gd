extends Node
class_name firing_handler
@export var projectile : PackedScene
@export var pivot : Marker2D
@onready var parent = get_parent()
func _fire():
	var b = projectile.instantiate()
	b.global_transform = pivot.global_transform
	parent.get_parent().add_child.call_deferred(b)
