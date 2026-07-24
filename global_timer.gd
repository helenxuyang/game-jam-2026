extends Node

const period = 0.02
const valid_window = 150

var global_ms: int
var timer: Timer

var is_paused: bool = false
var pause_time

signal count_sec

func _ready():
	self.timer = Timer.new()
	self.timer.wait_time = period
	self.timer.timeout.connect(_on_timeout)
	add_child(self.timer)

func _on_timeout():
	self.global_ms += (period * 1000)
	# print(global_ms)
	if is_paused: 
		if global_ms >= 1000:
			self.is_paused = false
			self.pause_time = null
	Hud.update_ability_ring_displays()
	
	var is_whole_second = self.global_ms % 1000 == 0
	if (is_whole_second):
		count_sec.emit()

func pause():
	self.is_paused = true
	self.pause_time = self.global_ms
	self.global_ms = 0
	Hud.update_ability_ring_displays()
	
