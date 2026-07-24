class_name AbilityCountdown
extends Control

var ability: Ability
var highlight_timer: Timer

static func create(ability: Ability):
	var scene = load("res://features/abilities/ability_countdown.tscn")
	var instance: AbilityCountdown = scene.instantiate()
	instance.ability = ability
	instance.set_name_label()
	instance.update_ring()
	instance.update_label()
	return instance

func set_name_label():
	$Name.text = self.ability.effect_name
	
func update_ring():
	$TextureProgressBar.tint_over = Color.WHITE
	var period_ms: int = self.ability.period * 1000
	var percent: float = 100 * float(GlobalCounter.global_ms % period_ms) / float(period_ms)
	prints("global", GlobalCounter.global_ms, "pd", period_ms, "mod", float(GlobalCounter.global_ms % period_ms), "percent", percent)
	$TextureProgressBar.value = percent

func update_label():
	$Label.text = str(self.ability.period)

func highlight():
	if self.ability.was_called != null:
		$TextureProgressBar.tint_over = Color.LAWN_GREEN if self.ability.was_called else Color.RED
	for i in range(10):
		await get_tree().process_frame
