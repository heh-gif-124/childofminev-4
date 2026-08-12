extends Node
class_name firing_handler
@export var projectile := load("res://SRC/Objects/Projectiles/Projectile.tscn")
@export var pivot : Marker2D
@onready var parent = get_parent()
func _fire():
	var b = projectile.instantiate()
	b.p_crit = PlayerStatsManager.cr
	b.p_crit_dmg = PlayerStatsManager.cdm
	b.dmg = PlayerStatsManager.damage
	b.global_transform = pivot.global_transform
	parent.get_parent().add_child.call_deferred(b)
