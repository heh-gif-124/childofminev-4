extends Node
class_name EnemySpawner

@onready var enemy_folder := Globals.load_folder_children("res://SRC/Enemies/enemies/")
@export var player: CharacterBody2D
@export var max_enemies_on_field: int = 3
@export var enemy_spawn_per_wave: int = 3
@export var room_manager: room_generation

@export_subgroup("Debugging")
@export var disabled := false
@export var room_threshold := 2

@export_subgroup("Starting")
@export var needs_time: bool = false
@export var time: float = 1.0

var enemy_on_field: int = 0
var is_waiting_timer: bool = false
@onready var parent := get_parent()

func _ready() -> void:
	if disabled:
		return

	if needs_time:
		is_waiting_timer = true
		await get_tree().create_timer(time, false, true, true).timeout
		is_waiting_timer = false

	if enemy_on_field <= 0:
		spawn_wave()

func _physics_process(_delta: float) -> void:
	if disabled or is_waiting_timer:
		return

	# Trigger new wave when all enemies are cleared
	if enemy_on_field <= 0:
		spawn_wave()

	# Safe threshold check (catches up if multiple rooms spawned at once without infinite looping)
	if is_instance_valid(room_manager):
		while room_manager.rooms_spawned_so_far >= room_threshold:
			room_threshold += 2
			max_enemies_on_field += 3
			enemy_spawn_per_wave += 3

func spawn_wave() -> void:
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

		if enemy_scene is String:
			enemy_scene = load(enemy_scene)

		var enemy_instance = enemy_scene.instantiate()

		var spawn_x = player.global_position.x + randf_range(-450, 450)
		var spawn_pos = Vector2(spawn_x, -350)

		parent.add_child(enemy_instance)
		enemy_instance.global_position = spawn_pos

		# Trigger animation directly via Autoload check
		if PillarManager:
			PillarManager.spawn_light_pillar_2d(spawn_pos)

		enemy_on_field += 1
		enemy_instance.tree_exited.connect(_on_enemy_removed)
		
func _on_enemy_removed() -> void:
	enemy_on_field = max(0, enemy_on_field - 1)