extends Node

const frequency = 0.25

var global_time: float = 0.0
var global_timer: Timer

signal count_sec

func _ready():
	self.global_timer = Timer.new()
	self.global_timer.wait_time = frequency
	self.global_timer.timeout.connect(_on_timeout)
	add_child(self.global_timer)
	
func _on_timeout():
	self.global_time += frequency
	var is_whole_second = is_equal_approx(self.global_time, roundf(self.global_time))
	if is_whole_second:
		count_sec.emit()
		

#Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
