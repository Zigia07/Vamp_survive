extends Node


@onready var sprite: Sprite2D = get_node("../Sprite2D")
@onready var enemy = get_tree().get_first_node_in_group("enemy")
#@export var tween_time: float = 0.4
#var tween_time: float = data.base_speed
@export var scale_max: float = 1.2
@export var scale_min: float = 0.8
var data: EnemyData

# / 2.2

func setup(enemy_data: EnemyData):
	data = enemy_data
	tween_anim()
	
func tween_anim():
	var tween: Tween = create_tween().set_loops()
	var tween_time: float = 60 / data.base_speed
	
	tween.set_trans(Tween.TRANS_QUINT)
	tween.set_ease(Tween.EASE_IN)
	
	tween.tween_property(sprite, "scale:y", data.sprite_scale * scale_max, tween_time)
	tween.parallel().tween_property(sprite, "scale:x", data.sprite_scale * scale_min, tween_time)
	
	tween.tween_property(sprite, "scale:y", data.sprite_scale * scale_min, tween_time)
	tween.parallel().tween_property(sprite, "scale:x", data.sprite_scale * scale_max, tween_time)
	
