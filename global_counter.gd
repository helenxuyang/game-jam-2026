extends Node

class_name Counter

var global_time: float = 0.0
var global_timer: Timer

signal count_sec

func _init():
	self.global_timer = Timer.new()
	self.global_timer.wait_time = 0.25
	self.global_timer.timeout.connect(_on_timeout)
	add_child(self.global_timer)
	self.global_timer.start()
	
func _on_timeout():
	var is_whole_second = is_equal_approx(self.global_time, roundf(self.global_time))
	if is_whole_second:
		count_sec.emit()
		

#Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
