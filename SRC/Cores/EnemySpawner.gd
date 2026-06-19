extends Timer
class_name EnemySpawner
@onready var enemy_folder = Globals.load_folder_children("res://SRC/Enemies/enemies/")
@export var player : CharacterBody2D
# Called when the node enters the scene tree for the first time.
@onready var parent = get_parent()
func _ready() -> void:
	timeout.connect(func():
		var t = enemy_folder.pick_random()
		var b = t.instantiate()
		parent.add_child(b)
		b.global_position.x = player.global_position.x + randf_range(-450,450)
		b.global_position.y = -350
		)
