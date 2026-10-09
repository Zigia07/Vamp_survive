extends CharacterBody2D

@onready var health: Health = $Health

@export var speed = 200
@export var damage = 4

func _ready() -> void:
	health.died.connect(_on_died)
	
func _process(delta: float) -> void:
	move()
	#print("player:", str(health.current_hp))
	
func _on_died():
	print("Player died")

func move():
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
