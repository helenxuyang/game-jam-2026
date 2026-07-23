extends Node

class_name Ability

var frequency: int
var current_count: int
var effect: Callable

const min_count = 1 # keeping this for now in case we change the count to 0 or whatever

func _init(frequency, effect):
	self.frequency = frequency
	self.current_count = frequency
	self.effect = effect
	GlobalCounter.count_sec.connect(self.update_count)
	
func reset_count():
	self.current_count = frequency
	
func update_count():
	if self.current_count == min_count:
		self.reset_count()
	else:
		self.current_count -= 1

func is_ready():
	return self.current_count == min_count

func activate():
	if self.is_ready():
		self.effect.call()
	
