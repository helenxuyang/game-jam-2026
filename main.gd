extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$Area2D.start()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_timer_timeout():
	$AudioStreamPlayer.play();
