class_name AbilityCountdown
extends Control

var highlight_timer: Timer

static func create(ability: Ability):
	var scene = load("res://features/abilities/ability_countdown.tscn")
	var instance: AbilityCountdown = scene.instantiate()
	instance.set_name_label(ability)
	instance.update_ring(ability)
	instance.update_label(ability)
	return instance

func set_name_label(ability: Ability):
	$Name.text = ability.effect.name

func get_percent(ability: Ability) -> int:
	var period_ms: int = ability.period * 1000
	return 100 * float(GlobalTimer.global_ms % period_ms) / float(period_ms)
	
func update_ring(ability: Ability):
	var percent: int = self.get_percent(ability)
	$TextureProgressBar.value = 100 - percent

func update_label(ability: Ability):
	$Label.text = str(ability.period)

func highlight(successful: bool):
	$TextureProgressBar.tint_over = Color.LAWN_GREEN if successful else Color.RED
	for i in range(40):
		await get_tree().process_frame
	$TextureProgressBar.tint_over = Color.WHITE
