extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.timeout.connect(func():
		Engine.time_scale = 1
		visible = false
		)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Skill"):
		Engine.time_scale = 0.1
		visible = true
		$Timer.start()
