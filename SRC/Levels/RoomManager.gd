extends Node
## This node handles everything about the rooms.
class_name RoomManager
@export_subgroup("trinket spawning (Monoliths, foliage, etc)")
@export var canspawntrinkets : bool = true
@export var trinkets_to_spawn : int = 5
@export var trinkets : Array[PackedScene]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_spawn_trinkets()

func _spawn_trinkets():
	if canspawntrinkets == true:
		for i in trinkets_to_spawn:
			var random = randi_range(0,1)
			if random == 1:
				var g = trinkets.pick_random().instantiate()
				g.z_index = -1
				g.global_position = Vector2(randf_range(-444,444),-46.0)
				get_parent().add_child.call_deferred(g)