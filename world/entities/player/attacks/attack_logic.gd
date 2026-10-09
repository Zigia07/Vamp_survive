#extends Node
#@onready var sprite: Sprite2D = $Sprite2D 
#@onready var hitbox: Area2D = $Hitbox
#@onready var collision_shape: CollisionShape2D = $Hitbox/CollisionShape2D
#
#var damage: int
#var cooldown: float
#var duration: float
#var attack_offset: Vector2
#var rotates_with_facing: bool
#
#func setup(data: AttackData):
	#collision_shape.shape = data.shape
	#damage = data.damage
	#cooldown = data.cooldown
	#duration = data.duration
	#attack_offset = data.offset
	#rotates_with_facing = data.rotates_with_facing
	#position = attack_offset
	#hitbox.monitoring = false
	#hitbox.body_entered.connect(_on_body_entered)
