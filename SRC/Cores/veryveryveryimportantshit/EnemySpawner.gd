extends Node
class_name EnemySpawner

@onready var enemy_folder = Globals.load_folder_children("res://SRC/Enemies/enemies/")
@export var player : CharacterBody2D
@export var max_enemies_on_field : int = 3
@export var enemy_spawn_per_wave : int = 3
@export var room_manager : room_generation

var enemy_on_field : int = 0
@onready var parent = get_parent()

func _ready() -> void:
	# Call deferred to ensure player and parent nodes are fully ready in the tree
	call_deferred("spawn_wave")

func _physics_process(_delta: float) -> void:
	# Keep this as a safe check if a wave dies out
	if enemy_on_field <= 0:
		spawn_wave()

func spawn_wave() -> void:
	# Prevent spawning if we already have enemies active
	if enemy_on_field > 0:
		return

	if not is_instance_valid(player):
		push_warning("EnemySpawner: Player reference is missing or invalid!")
		return

	if enemy_folder.is_empty():
		push_warning("EnemySpawner: No enemies found in enemy_folder!")
		return

	var amount_to_spawn = min(enemy_spawn_per_wave, max_enemies_on_field)

	for i in amount_to_spawn:
		var enemy_scene = enemy_folder.pick_random()
		var enemy_instance = enemy_scene.instantiate()

		var spawn_x = player.global_position.x + randf_range(-450, 450)
		var spawn_pos = Vector2(spawn_x, -350)

		# Option A: Add synchronously so global_position works immediately
		parent.add_child(enemy_instance)
		enemy_instance.global_position = spawn_pos

		PillarManager.spawn_light_pillar_2d(spawn_pos)

		enemy_on_field += 1

		# Connect signal to update count on death
		enemy_instance.tree_exited.connect(_on_enemy_removed)

func _on_enemy_removed() -> void:
	enemy_on_field = max(0, enemy_on_field - 1)
