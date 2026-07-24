class_name Ability

var frequency: int
var current_count: float
var effect_name: String
var effect: Callable

func _init(frequency, effect_name, effect):
	self.frequency = frequency
	self.current_count = 0
	self.effect_name = effect_name
	self.effect = effect
	
func reset_count():
	self.current_count = 0
	
func increment_count():
	if self.current_count >= frequency:
		self.reset_count()
	else:
		self.current_count += GlobalCounter.frequency

func is_ready():
	return int(roundf(self.current_count)) == frequency

func fire() -> bool:
	var should_call = GlobalCounter.is_on_beat() && self.is_ready()
	if should_call:
		self.effect.call()
	self.reset_count()
	return should_call
