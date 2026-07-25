class_name Ability

var period: int
var current_count: float
var effect: AbilityEffect
var was_called

func _init(period, effect):
	self.period = period
	self.effect = effect
		
func is_ready():
	var period_ms = period * 1000
	var closest_multiple = snappedi(GlobalTimer.global_ms, period_ms)
	var diff = abs(closest_multiple - GlobalTimer.global_ms)
	return diff < GlobalTimer.valid_window

func fire() -> bool:
	var should_call = self.is_ready()
	if should_call:
		self.effect.function.call()
		self.was_called = true
	else:
		self.was_called = false
	return should_call
