extends Node

signal upgrade_chose(id: String)
signal SkillUse(id: Array[String])
signal AddCombo(id: String)
signal upgrade_Triggered
var boss_progress = 0 # Teleporter Progress reaches 100, then boss progress starts appearing
var teleporter_progress = 0 
#Stats
var base_max_hp = 50
var base_crit_rate = 45
var base_crit_dmg = 75
var current_exp = 0
var moneh = 0
func calculate_final_damage(dmg,crit_chance:float,crit_dmg):
	var roll = randi_range(1,100)
	var is_crit: bool = roll <= crit_chance
	var multiplier: float = 1.0 + (crit_dmg/100.0)
	var normal_dmg = dmg
	var critted_dmg = dmg * multiplier
	var final = critted_dmg if is_crit else normal_dmg
	return{
		"is_crit" : is_crit,
		"normal_dmg" : normal_dmg,
		"crit_dmg" : crit_dmg,
		"final" : final
	}

func load_folder_children(path: String) -> Array:
	var loaded_assets = []
	var dir = DirAccess.open(path)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			# Ignore hidden files and directories
			if not dir.current_is_dir():
				# Only load specific file types (e.g., scenes)
				if file_name.ends_with(".tscn"):
					var full_path = path + "/" + file_name
					var asset = load(full_path)
					if asset:
						loaded_assets.append(asset)
			
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("An error occurred when trying to access the path: ", path)
		
	return loaded_assets
