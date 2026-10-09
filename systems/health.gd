extends Node2D
class_name Health

signal died
signal damaged(amount)

@export var max_hp: float = 10.0
var current_hp: float

func _ready() -> void:
	current_hp = max_hp
	
func take_damage(amount: float):
	current_hp -= amount
	damaged.emit(amount)
	if current_hp <= 0:
		died.emit()
		
	
