extends Node2D

const enemy = preload("res://enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Enemy =  enemy.instantiate()
	add_child(Enemy)
	Enemy.position = Vector2(10000, -1000)
	GlobalTimer.timer.start()
	AbilitiesManager.show_ability_countdowns()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
