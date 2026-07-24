class_name Ability

var period: int
var current_count: float
var effect_name: String
var effect: Callable
var was_called: bool

func _init(period, effect_name, effect):
	self.period = period
	self.effect_name = effect_name
	self.effect = effect
		
func is_ready():
	var period_ms = period * 1000
	var closest_multiple = snappedi(GlobalTimer.global_ms, period_ms)
	var diff = abs(closest_multiple - GlobalTimer.global_ms)
	return diff < GlobalTimer.valid_window

func fire() -> bool:
	var should_call = self.is_ready()
	if should_call:
		self.effect.call()
	self.was_called = should_call
	return should_call
