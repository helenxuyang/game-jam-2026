extends Node
const enemy = preload("res://enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$Area2D.start()
	var Enemy =  enemy.instantiate()
	add_child(Enemy)
	Enemy.position = Vector2(10000, -1000)
	GlobalTimer.timer.start()
	GlobalTimer.count_sec.connect(self.play_tick_audio)

func play_tick_audio():
	var sec: int = GlobalTimer.global_ms / 1000
	$MetronomeAudioPlayer.play();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
