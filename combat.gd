extends Node2D

const enemy = preload("res://enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Enemy =  enemy.instantiate()
	add_child(Enemy)
	Enemy.position = Vector2(10000, -1000)
	Hud.build_ability_countdowns()
	GlobalTimer.timer.start()
	GlobalTimer.seconds_timer.start()
	GlobalTimer.count_sec.connect(func (): $MetronomeAudioStreamPlayer.play(0.04))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
