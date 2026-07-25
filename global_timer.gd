extends Node

const period = 0.02
const valid_window = 100

var global_ms: int = 0
var timer: Timer

var num_seconds: int = 0
var seconds_timer: Timer

var is_paused: bool = false
var pause_time

signal count_sec

func _ready():
	self.timer = Timer.new()
	self.timer.wait_time = period
	self.timer.timeout.connect(_on_timeout)
	add_child(self.timer)
	
	self.seconds_timer = Timer.new()
	self.seconds_timer.wait_time = 1
	self.seconds_timer.timeout.connect(_on_seconds_timeout)
	add_child(self.seconds_timer)

func _on_timeout():	
	AbilitiesManager.update_ability_countdowns()
	if !GlobalTimer.is_paused:
		self.global_ms += int(period * 1000)

func get_last_sec() -> int:
	@warning_ignore("integer_division")
	return GlobalTimer.global_ms / 1000

func get_closest_sec() -> int:
	@warning_ignore("integer_division")
	return snappedi(GlobalTimer.global_ms, 1000) / 1000
	
func pause():
	var last_sec: int = self.get_last_sec()
	var closest_sec: int = self.get_closest_sec()
	
	# clicked on time before sec
	if last_sec != closest_sec:
		# pause, will unpause on next whole sec
		self.is_paused = true
		self.pause_time = self.global_ms
	# clicked on time after sec
	else:
		self.unpause()
		# pretend the previous second was 0
		self.global_ms = self.global_ms % 1000
		# keep seconds timer in sync
		self.seconds_timer.start()

func unpause():
	self.is_paused = false
	self.pause_time = null
		
func _on_seconds_timeout():
	count_sec.emit()
	num_seconds += 1
	if is_paused:
		self.unpause()
		self.global_ms = 0
		
	
