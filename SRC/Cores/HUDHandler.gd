extends HBoxContainer

@onready var player = $"../../../../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	#HP Bar handler
	$VBoxContainer/HealthBar.max_value=player.max_hp
	$VBoxContainer/HealthBar.value=player.hp
	#SP Bar handler
	
	if player.hp <= 60:
		$TextureRect.texture = load("res://Sprites/Sprites/Player/Player_icon_slightly_hurted.png")
	if player.hp <= 20:
		$TextureRect.texture = load("res://Sprites/Sprites/Player/Player_icon_hurted_BADLY.png")
	if player.hp <= 0:
		$TextureRect.texture = load("res://Sprites/Sprites/Player/Player_icon_dead.png")
	if Input.is_action_just_pressed("hurt_test"):
		player.hp -= 15
