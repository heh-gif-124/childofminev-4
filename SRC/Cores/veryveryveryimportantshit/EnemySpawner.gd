extends Timer
class_name EnemySpawner

@onready var enemy_folder = Globals.load_folder_children("res://SRC/Enemies/enemies/")
@export var player : CharacterBody2D
@export var max_enemies_on_field : int = 3
@export var enemy_spawn_per_wave : int = 3
@export var room_manager : room_generation
var enemy_on_field : int = 0
@onready var parent = get_parent()

func _ready() -> void:
	timeout.connect(_on_timeout)
	
	if is_stopped():
		start()

	# Wait 1 frame so player and parent nodes are fully loaded in the tree
	call_deferred("spawn_wave")

func _on_timeout() -> void:
	
	# Backup check: if field is cleared, trigger next wave
	if enemy_on_field <= 0:
		spawn_wave()

func spawn_wave() -> void:
	# Debug print to verify it's reaching this function
	if not is_instance_valid(player):
		push_warning("EnemySpawner: Player reference is missing or invalid!")
		return

	if enemy_folder.is_empty():
		push_warning("EnemySpawner: No enemies found in enemy_folder!")
		return

	# Only spawn if field is cleared
	if enemy_on_field <= 0:
		var amount_to_spawn = min(enemy_spawn_per_wave, max_enemies_on_field)

		for i in amount_to_spawn:
			var enemy_scene = enemy_folder.pick_random()
			var enemy_instance = enemy_scene.instantiate()

			var spawn_x = player.global_position.x + randf_range(-450, 450)
			var spawn_pos = Vector2(spawn_x, -350)

			parent.add_child(enemy_instance)
			enemy_instance.global_position = spawn_pos

			PillarManager.spawn_light_pillar_2d(spawn_pos)

			enemy_on_field += 1

			# Connect removal signal
			enemy_instance.tree_exited.connect(_on_enemy_removed)

func _on_enemy_removed() -> void:
	enemy_on_field = max(0, enemy_on_field - 1)

	# Trigger next wave the second the last enemy is freed
	if enemy_on_field == 0:
		spawn_wave()
