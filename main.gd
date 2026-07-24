extends Node
const enemy = preload("res://enemy.tscn")
var tickCt = 1

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
	
	if(tickCt%Hud.ability_countdowns[0].ability.frequency == 0):
		$AudioStreamPlayer1.play();
	if(tickCt%Hud.ability_countdowns[1].ability.frequency == 0):
		$AudioStreamPlayer2.play();
	if(tickCt%Hud.ability_countdowns[2].ability.frequency == 0):
		$AudioStreamPlayer3.play();
	if(tickCt%Hud.ability_countdowns[3].ability.frequency == 0):
		$AudioStreamPlayer4.play();
	tickCt+=1
