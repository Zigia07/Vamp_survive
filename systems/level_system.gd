extends Node

@export var level: = 1
@export var xp: = 0
@export var xp_to_next_level: = 15
var xp_scaling: = 1.2

signal player_leveled_up(level: int)
signal xp_changed(current_xp: int, next_level_xp: int)

func add_xp(amount):
	xp += amount
	print("xp: ", xp, " / ", xp_to_next_level, "  (level ", level, ")")
	while xp >= xp_to_next_level:
		level_up()
	xp_changed.emit(xp, xp_to_next_level)

func level_up():
	xp -= xp_to_next_level
	xp_to_next_level = int(xp_to_next_level * xp_scaling)
	level += 1
	print("LEVEL UP! now level ", level, " : next threshold: ", xp_to_next_level)
	player_leveled_up.emit(level)
	#SkillTree.available_points += 1
