class_name Enemy
extends Area2D

var max_health: float = 50.0
var health = max_health
var follow_rad = 200
var follow_speed = 1

@onready var health_bar = $HealthBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if((position - player.position).length() > follow_rad):
		position += (player.position - position).normalized()*follow_speed
	health_bar.value = health/max_health
	if self.health <= 0:
		self.queue_free()
	
static func create_fast_enemy() -> Enemy:
	var scene = load("res://enemy.tscn")
	var instance: Enemy = scene.instantiate()
	instance.scale = Vector2(0.5, 0.5)
	instance.follow_speed = 3
	instance.max_health = 10.0
	instance.health = instance.max_health
	return instance

static func create_slow_enemy() -> Enemy:
	var scene = load("res://enemy.tscn")
	var instance: Enemy = scene.instantiate()
	instance.scale = Vector2(1.5, 1.5)
	instance.follow_speed = 0.5
	instance.max_health = 100.0
	instance.health = instance.max_health
	return instance

static var enemy_creators: Array[Callable] = [
	create_fast_enemy,
	create_slow_enemy
]
	
