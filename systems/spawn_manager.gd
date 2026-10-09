extends Node

var wave_data: WaveData
@export var waves: Array[WaveData]
var passed_time: float = 0.0
var timer: Timer
var despawn_timer: Timer


func _ready() -> void:
	_update_current_wave()
	spawn_timer()

func spawn_enemy():
	_update_current_wave()
	var data: EnemyData = wave_data.enemy_pool.pick_random()
	var enemy = data.scene.instantiate()
	%PathFollow2D.progress_ratio = randf()
	enemy.global_position = %PathFollow2D.global_position
	get_tree().current_scene.add_child(enemy)
	enemy.setup(data)

	
func spawn_timer():
	timer = Timer.new()
	timer.wait_time = wave_data.spawn_rate
	timer.timeout.connect(spawn_enemy)
	add_child(timer)
	timer.start()
	
func _update_current_wave():
	var current_wave: WaveData = null
	for wave_entry in waves:
		if wave_entry.wave_start <= passed_time:
			if current_wave == null or wave_entry.wave_start > current_wave.wave_start:
				current_wave = wave_entry
	if current_wave != null and current_wave != wave_data:
		wave_data = current_wave
		if timer != null:
			timer.wait_time = wave_data.spawn_rate

func _process(delta: float) -> void:
	passed_time += delta 
