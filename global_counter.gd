extends Node

const frequency = 0.05 

var global_time: float = 0.0
var global_timer: Timer
var whole_sec_counter: int = 0

signal count_sec

func _ready():
	self.global_timer = Timer.new()
	self.global_timer.wait_time = frequency
	self.global_timer.timeout.connect(_on_timeout)
	add_child(self.global_timer)
	
func _on_timeout():
	self.global_time += frequency
	self.whole_sec_counter += 1
	var is_whole_second = self.whole_sec_counter == 1/frequency 
	if is_whole_second:
		count_sec.emit()
		self.whole_sec_counter = 0

func is_on_beat() -> bool:
	var valid_range = 0.1 # 100ms
	var closest_beat: int = roundf(self.global_time)
	var rounded_time = snapped(self.global_time, 0.01) # round to 2 decimals to avoid floating point issues
	return abs(rounded_time - closest_beat) <= valid_range

func reset_time():
	self.global_time = 0
