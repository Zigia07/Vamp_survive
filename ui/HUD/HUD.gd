extends CanvasLayer

@onready var health_bar: ProgressBar = $HealthBar
@onready var xp_bar: ProgressBar = $XPBar
@onready var level_label: Label = $LevelLabel

func _ready():
	var player = get_tree().get_first_node_in_group("player")
	var level_system = get_tree().get_first_node_in_group("level_system")
	
	health_bar.max_value = player.health.max_hp
	health_bar.value = player.health.current_hp
	player.health.damaged.connect(_on_player_damaged)
	
	xp_bar.max_value = level_system.xp_to_next_level
	xp_bar.value = level_system.xp
	level_system.xp_changed.connect(_on_xp_changed)
	
	level_label.text = str(level_system.level)
	level_system.player_leveled_up.connect(_on_leveled_up)
	
func _on_player_damaged(_amount):
	var player = get_tree().get_first_node_in_group("player")
	health_bar.value = player.health.current_hp

func _on_xp_changed(current_xp: int, next_level_xp: int):
	xp_bar.max_value = next_level_xp
	xp_bar.value = current_xp
	
func _on_leveled_up(level: int):
	level_label.text = str(level)
	
