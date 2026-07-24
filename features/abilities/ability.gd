class_name Ability

var frequency: int
var current_count: int
var effect_name: String
var effect: Callable

func _init(frequency, effect_name, effect):
	self.frequency = frequency
	self.current_count = 1
	self.effect_name = effect_name
	self.effect = effect
	
func reset_count():
	self.current_count = 1
	
func increment_count():
	if self.current_count == frequency:
		self.reset_count()
	else:
		self.current_count += 1

func is_ready():
	return self.current_count == frequency

func fire():
	if self.is_ready():
		self.effect.call()
	self.reset_count()
