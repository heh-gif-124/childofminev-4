extends HBoxContainer

@onready var player = $"../../../../Player"
@onready var staff = $"../../../../Staff"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	#HP Bar handler
	$VBoxContainer/HealthBar.max_value=player.max_hp
	$VBoxContainer/HealthBar.value=player.hp
	$VBoxContainer/EnergyBar.max_value=staff.max_energy
	$VBoxContainer/EnergyBar.value=staff.energy
	#SP Bar handler
	
	if player.hp <= 60:
		$TextureRect.texture = load("res://Sprites/Sprites/Player/Player_icon_slightly_hurted.png")
	if player.hp <= 20:
		shake_node_fear($TextureRect,0.25,0.1)
		$TextureRect.texture = load("res://Sprites/Sprites/Player/Player_icon_hurted_BADLY.png")
	if player.hp <= 0:
		$TextureRect.texture = load("res://Sprites/Sprites/Player/Player_icon_dead.png")
	if Input.is_action_just_pressed("hurt_test"):
		shake_node_fear($TextureRect,0.5,0.35)
		player.hp -= 15
	
	
func shake_node_fear(node: Control, base_intensity: float, duration: float) -> void:
	var tween = create_tween()
	var original_pos = node.position
	
	var elapsed = 0.0
	while elapsed < duration:
		# 1. Ultra-fast shivering intervals (0.015 to 0.03 seconds)
		var time_per_shake = randf_range(0.015, 0.03) 
		
		# 2. Randomly alternate between tight shivers and massive panic jolts
		var panic_modifier = randf_range(0.3, 1.2)
		if randf() > 0.88: 
			panic_modifier *= 3.0 # Sudden adrenaline spike / heart pounding jolt!
			
		var current_intensity = base_intensity * panic_modifier
		
		# Calculate the erratic offset
		var offset = Vector2(
			randf_range(-current_intensity, current_intensity),
			randf_range(-current_intensity, current_intensity)
		)
		
		# 3. Use TRANS_SINE to make the movements feel sharp, violent, and organic
		tween.tween_property(node, "position", original_pos + offset, time_per_shake).set_trans(Tween.TRANS_SINE)
		
		elapsed += time_per_shake
		
	# Smoothly snap back to reality once the panic attack subsides
	tween.tween_property(node, "position", original_pos, 0.05).set_trans(Tween.TRANS_SINE)
