extends Node

@export var upgrade_pool: Array[UpgradeData]
var upgrade_choice_scene = preload("res://ui/upgrade/upgrade_choice.tscn")

func _ready() -> void:
	var level_system = get_tree().get_first_node_in_group("level_system")
	level_system.player_leveled_up.connect(_on_leveled_up)
	
func _on_leveled_up(_level):
	get_tree().paused = true
	var choices = _pick_upgrade_choices(3)
	var ui = upgrade_choice_scene.instantiate()
	get_tree().current_scene.add_child(ui)
	ui.upgrade_selected.connect(_on_upgrade_selected)
	ui.show_choices(choices)
	
func _pick_upgrade_choices(count: int) -> Array[UpgradeData]:
	var pool_copy = upgrade_pool.duplicate()
	pool_copy.shuffle()
	return pool_copy.slice(0, count)

func _on_upgrade_selected(upgrade: UpgradeData):
	var player = get_tree().get_first_node_in_group("player")
	var attack = player.get_node("Attack")
	
	match upgrade.stat:
		UpgradeData.Stat.DAMAGE:
			attack.damage += upgrade.amount
		UpgradeData.Stat.SPEED:
			player.speed += upgrade.amount
		UpgradeData.Stat.MAX_HP:
			player.health.max_hp += upgrade.amount
		UpgradeData.Stat.COOLDOWN:
			attack.damage -= upgrade.amount
		UpgradeData.Stat.AOE:
			attack.aoe_scale += upgrade.amount
			attack.aoe_collision.scale = Vector2(attack.aoe_scale, attack.aoe_scale)
	get_tree().paused = false
