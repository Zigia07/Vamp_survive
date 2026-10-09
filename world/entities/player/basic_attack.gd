extends Area2D

@export var damage: float = 5.0
@export var cooldown: float = 5.0
@export var active_time: float = 5.0
@export var aoe_scale: float = 1.0

@onready var aoe_collision: CollisionShape2D = $AOE

func _ready() -> void:
	monitoring = false
	$AOE.disabled = true
	$AOE.scale = Vector2(aoe_scale, aoe_scale)
	_start_cooldown()
	
func _start_cooldown() -> void:
	await get_tree().create_timer(cooldown).timeout
	_activate()
	
func _activate():
	monitoring = true
	$AOE.disabled = false
	for body in get_overlapping_bodies():
		_damage_enemy_group(body)
	
	await get_tree().create_timer(active_time).timeout
	
	monitoring = false
	$AOE.disabled = true
	_start_cooldown()
	
func _on_body_entered(body: Node2D):
	_damage_enemy_group(body)
		
func _damage_enemy_group(body: Node2D):
	if body.is_in_group("enemy"):
		body.hit_flash_anim_player.play("flash")
		body.health.take_damage(damage)
