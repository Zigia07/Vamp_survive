extends Resource
class_name EnemyData

@export var enemy_name: String = ""
@export var scene: PackedScene
@export var sprite: Texture2D
@export var sprite_scale: float = 1.0
@export var collision_scale: float = 1.0
@export var base_hp: float = 10.0
@export var base_speed: float = 200.0
@export var base_damage: float = 2.0
@export var xp_value: int = 5
