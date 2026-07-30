extends Node
class_name SkillManager
var combo_list = []
@onready var combo_visibler = $"../ComboCombativeThing"
@onready var max_combo = 3
func _ready() -> void:
	get_parent().visible = false
	Globals.AddCombo.connect(func(id):
		if combo_list.size() < max_combo:
			combo_list.append(id)
			print(combo_list)
	)
func _physics_process(delta: float) -> void:
	if combo_list.size() == max_combo:
		Globals.SkillUse.emit(combo_list)
		combo_list.clear()
		get_parent().visible = false
		Engine.time_scale = 1.0 # Return to normal
		combo_list.clear()          # Fail the combo if they didn't finish
	var display_text = ""
	for i in combo_list:
		display_text += i + " " # Adds a space between symbols
	
	combo_visibler.text = display_text
	
	_appear_handler()
func _appear_handler():
	if Input.is_action_just_pressed("Skill"):
		start_qte_sequence(3.3)
func start_qte_sequence(duration: float):
	get_parent().visible = true
	Engine.time_scale = 0.05 # Enter slow-mo
	
	# Create a timer that lasts 'duration' seconds
	# 'timeout' is the signal it sends when finished
	await get_tree().create_timer(duration * Engine.time_scale).timeout
	get_parent().visible = false
	Engine.time_scale = 1.0 # Return to normal
	combo_list.clear()          # Fail the combo if they didn't finish
	
