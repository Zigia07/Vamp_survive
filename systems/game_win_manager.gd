extends Node2D

signal game_won()
signal game_lost()
signal updated_kills(current: int, target: int)

@export var kill_target: int = 50


var kills: int = 0
var game_over: bool = false

func register_kills():
	kills += 1
	updated_kills.emit(kills, kill_target)
	if kills >= kill_target:
		_win()

func _ready() -> void:
	var player = get_tree().get_first_node_in_group("player")
	player.health.died.connect(_on_player_died)
	
func _on_player_died():
	_lose()

func _lose():
	game_over = true
	get_tree().paused = true
	game_lost.emit()
	
func _win():
	game_over = true
	get_tree().paused = true
	game_won.emit()
