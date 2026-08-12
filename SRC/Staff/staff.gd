extends Node2D
#This script mostly only handles the stuff that the staff needs (ex: player)
#This is ALSO where the main stuff is handled
@export var target : Node2D

@export var timer : Timer

var cd : bool = false

var player
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	timer.timeout.connect(func():
		cd = false
	)	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack") and !(PlayerStatsManager.energy <= 0) and player.is_blocking == false and cd == false:
		$AudioStreamPlayer2D.play(0)
		PlayerStatsManager.energy -= 1
		$firing_handler._fire()
		print("ur dmg: " + str(PlayerStatsManager.damage))
		timer.start(0)
		cd = true
		
	if Input.is_action_just_pressed("reload") and PlayerStatsManager.energy <= 0:
		$AnimationPlayer.play("Reload")
		PlayerStatsManager.energy = PlayerStatsManager.max_energy
