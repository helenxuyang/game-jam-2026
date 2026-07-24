extends Node
const enemy = preload("res://enemy.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$Area2D.start()
	var Enemy =  enemy.instantiate()
	add_child(Enemy)
	Enemy.position = Vector2(10000, -1000)
	GlobalCounter.global_timer.start()
	GlobalCounter.count_sec.connect(self.play_tick_audio)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func play_tick_audio():
	$AudioStreamPlayer.play();
