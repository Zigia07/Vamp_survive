extends Label

func _ready() -> void:
	var win_manager = get_tree().get_first_node_in_group("win_manager")
	if win_manager:
		win_manager.updated_kills.connect(_on_kills_updated)
		# initialize immediately in case some kills already happened
		_on_kills_updated(win_manager.kills, win_manager.kill_target)

func _on_kills_updated(current: int, target: int) -> void:
	text = "Kills: %d / %d" % [current, target]
