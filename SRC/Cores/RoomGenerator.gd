extends Node
class_name room_generation

@export var room_export : String


var rooms : Array
var parent_of_this_class : Node2D
var reverie : PackedScene = load("res://SRC/Objects/Reverie.tscn")
var platform : Array
var initial_room_spacing = 2592
var first_room_spawned_right = false
var first_room_spawned_left = false
@export var room_spacing : float = 864.0  # Distance between rooms

# --- Time-based Generation Variables ---
var total_time_elapsed : float = 0.0
var rooms_spawned_so_far : int = 0

# Track the building progress for both sides independently
var right_index : int = 0
var left_index : int = 0

# How often (in seconds) a new room should be allowed to spawn
@export var spawn_interval : float = 10.0 

func _ready() -> void:
	Globals.boss_progress = 0
	rooms = Globals.load_folder_children(room_export)
	platform = Globals.load_folder_children("res://SRC/Objects/platforms/")
	parent_of_this_class = get_parent()
	_generate_initial_rooms()
	_generate_initial_platforms()


func _process(delta: float) -> void:
	total_time_elapsed += delta
	var target_room_count = floor(total_time_elapsed / spawn_interval)
	
	if target_room_count > rooms_spawned_so_far:
		Globals.teleporter_progress += 25
		print(Globals.teleporter_progress)
		# 1. SPAWN RIGHT ROOM
		var right_x_pos : float = parent_of_this_class.global_position.x + initial_room_spacing + (right_index * room_spacing)
		right_index += 1
		
		spawn_dynamic_room(right_x_pos)
		spawn_dynamic_reverie(right_x_pos)
		spawn_dynamic_platform(right_x_pos)
		print("Right room spawned: " + str(right_x_pos))
		rooms_spawned_so_far += 1

		# 2. SPAWN LEFT ROOM
		var left_x_pos : float = parent_of_this_class.global_position.x - initial_room_spacing - (left_index * room_spacing)
		left_index += 1
	
		spawn_dynamic_room(left_x_pos)
		spawn_dynamic_reverie(left_x_pos)
		spawn_dynamic_platform(left_x_pos)
		print("Left room spawned: " + str(left_x_pos))
		# FIXED: Indented this line so it only counts up when a room actually spawns
		rooms_spawned_so_far += 1

func _generate_initial_rooms() -> void:
	for i in get_children():
		var r = rooms.pick_random()
		var t = r.instantiate()
		parent_of_this_class.add_child.call_deferred(t)
		t.global_position = i.global_position
		t.global_position.y = 0


func spawn_dynamic_room(target_x: float) -> void:

	var final_y = 0.0
	
	var r = rooms.pick_random()
	var t = r.instantiate()
	parent_of_this_class.add_child.call_deferred(t)
	
	# Position the room horizontally, but start it 400 pixels lower than its final spot
	t.global_position.x = target_x
	t.global_position.y = final_y + 400.0 
	
	# Start completely invisible so it doesn't jarringly pop into view at the bottom
	t.modulate.a = 0.0
	
	# Wait one frame for call_deferred to safely mount the room node to the tree
	await get_tree().process_frame
	
	# Create a smooth tween to slide the room up out of the ground
	var entry_tween = create_tween().set_parallel(true)
	
	# Transitions the room vertically up to final_y over 0.5 seconds
	entry_tween.tween_property(t, "global_position:y", final_y, 0.5)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
		
	# Fades the opacity in to full visibility slightly faster than the movement
	entry_tween.tween_property(t, "modulate:a", 1.0, 0.3)

func spawn_dynamic_reverie(target_x: float) -> void:
	var rand = randi_range(1, 2)
	if rand == 1:
		var r = reverie.instantiate()
		parent_of_this_class.add_child.call_deferred(r)
		
		var min_x = target_x - (room_spacing / 2)
		var max_x = target_x + (room_spacing / 2)
		r.global_position.x = randf_range(min_x, max_x)
		
		# --- ANIMATION FOR THE REVERIE ---
		# Make it slide up smoothly from just below its target position
		var target_y = r.global_position.y
		r.global_position.y += 100.0 # Start 100 pixels lower down
		r.modulate.a = 0.0            # Start invisible
		
		await get_tree().process_frame
		
		var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		tween.tween_property(r, "global_position:y", target_y, 0.5) # Slides up
		tween.tween_property(r, "modulate:a", 1.0, 0.4)             # Fades in

func spawn_dynamic_platform(target_x: float) -> void:
	var rand = randi_range(1, 2)
	if rand == 2:
		var rp = platform.pick_random()
		var r = rp.instantiate()
		parent_of_this_class.add_child.call_deferred(r)
		
		var min_x = target_x - (room_spacing / 2)
		var max_x = target_x + (room_spacing / 2)
		r.global_position.x = randf_range(min_x, max_x)
		
		# --- ANIMATION FOR THE REVERIE ---
		# Make it slide up smoothly from just below its target position
		r.global_position.y = randf_range(-550,-400)



func _generate_initial_platforms() -> void:
	for i in get_children():
		var rand = randi_range(1, 2)
		if rand == 2:
			var rp = platform.pick_random()
			var r = rp.instantiate()
			parent_of_this_class.add_child.call_deferred(r)
			var target_x = i.global_position.x
			var min_x = target_x - (room_spacing / 2)
			var max_x = target_x + (room_spacing / 2)
			r.global_position.x = randf_range(min_x, max_x)
			
			# --- ANIMATION FOR THE REVERIE ---
			# Make it slide up smoothly from just below its target position
			r.global_position.y = randf_range(-550,-400)
