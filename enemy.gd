class_name Enemy
extends Area2D

var max_health = 50.0
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
	pass
