extends Node
var current_exp = 0
signal upgrade_chose(id: String)
signal SkillUse(id: Array[String])
signal AddCombo(id: String)
var current_enemies_on_field = 0
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
