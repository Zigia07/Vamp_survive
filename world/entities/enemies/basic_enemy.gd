extends CharacterBody2D
var xp_drop = preload("res://world/entities/pick_ups/xp_drop.tscn")
@onready var sprite: Sprite2D = $Sprite2D 
@onready var health: Health = $Health
@onready var hitbox: Area2D = $Hitbox
@onready var collisionshape2d2: CollisionShape2D = $CollisionShape2D2
@onready var hit_flash_anim_player = $HitFlashAnimationPlayer

var data: EnemyData

var max_hp: float
var speed: float
var damage: float
var xp_value: int
var player: Node2D

func _ready() -> void:
	health.died.connect(_on_died)
	player = get_tree().get_first_node_in_group("player")
	
	$Hitbox.body_entered.connect(_on_body_entered)
	
func _process(delta: float) -> void:
	move()
	#print(str(health.current_hp))
	
func move():
	var direction = (player.global_position - global_position).normalized()
	velocity = speed * direction
	move_and_slide()

func _on_died():
	call_deferred("spawn_xp")
	var win_manager = get_tree().get_first_node_in_group("win_manager")
	win_manager.register_kills()
	queue_free()
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.health.take_damage(damage)
	if body.is_in_group("xp"):
		body.queue_free()
	
func spawn_xp():
	var xp = xp_drop.instantiate()
	get_tree().current_scene.add_child(xp)
	xp.global_position = global_position
	xp.setup(data)

func setup(data):
	self.data = data
	sprite.texture = data.sprite
	sprite.scale = Vector2(data.sprite_scale, data.sprite_scale)
	hitbox.scale = Vector2(data.collision_scale, data.collision_scale)
	collisionshape2d2.scale = Vector2(data.collision_scale, data.collision_scale)
	health.max_hp = data.base_hp
	health.current_hp = data.base_hp
	speed = data.base_speed
	damage = data.base_damage
	xp_value = data.xp_value
	
	$Tween_Anim.setup(data)
	
