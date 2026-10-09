extends Area2D

#Figure out to connect to monster xp value
var xp_value: int

@onready var level_system = get_tree().get_first_node_in_group("level_system")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		level_system.add_xp(xp_value)
		queue_free()
		
func setup(data: EnemyData):
	xp_value = data.xp_value
