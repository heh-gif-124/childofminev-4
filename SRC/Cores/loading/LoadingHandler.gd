extends Node2D

var scene_path
var time_elapsed
var scene_loading = false
var scene_to_be_loaded
@export var splash_t : Array[String]

# Grab a reference to your Progress Bar node
@onready var progress_bar: ProgressBar = $ProgressBar 

func _ready() -> void:
	$Text.text = "* " + splash_t.pick_random()
	# Initialize progress bar to 0
	progress_bar.value = 0 
	_load_screen(Globals.scene_to_be_loaded)

func _load_screen(scene:String):
	if scene:
		scene_path = scene
		time_elapsed = Time.get_ticks_msec()
		
		ResourceLoader.load_threaded_request(scene_path)
		scene_loading = true

func _process(delta: float) -> void:
	if scene_loading:
		var progress = []
		var status = ResourceLoader.load_threaded_get_status(scene_path, progress)
		
		if status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS:
			# progress[0] returns a float from 0.0 to 1.0. 
			# Multiplying it by 100 converts it to a standard 0-100 percentage scale.
			progress_bar.value = progress[0] * 100
			print("Loading: ", progress_bar.value, "%")
		
		elif status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
			# Force progress bar to 100% just in case it finishes instantly
			progress_bar.value = 100
			
			scene_to_be_loaded = ResourceLoader.load_threaded_get(scene_path)
			
			# OPTIONAL TIP: Since you went through the trouble of threaded loading,
			# using change_scene_to_packed() avoids making Godot reload it from disk again!
			get_tree().change_scene_to_packed(scene_to_be_loaded)
			
			# Stop processing
			scene_loading = false
