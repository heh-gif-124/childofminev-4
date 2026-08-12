extends Control
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	#HP Bar handler
	$HealthBar.max_value = PlayerStatsManager.max_hp
	$HealthBar.value = PlayerStatsManager.hp
	#SP Bar handler
	$EnergyBar.max_value = PlayerStatsManager.max_energy
	$EnergyBar.value = PlayerStatsManager.energy
	if PlayerStatsManager.hp <= (50.0/100.0)*PlayerStatsManager.max_hp:
		$TextureRect.texture = load("res://Sprites/Sprites/Player/Player_icon_slightly_hurted.png")
	if PlayerStatsManager.hp <= (30.0/100.0)*PlayerStatsManager.max_hp:
		shake_node_fear($TextureRect,0.25,0.1)
		$TextureRect.texture = load("res://Sprites/Sprites/Player/Player_icon_hurted_BADLY.png")
	if PlayerStatsManager.hp <= 0:
		$TextureRect.texture = load("res://Sprites/Sprites/Player/Player_icon_dead.png")
	
	
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
