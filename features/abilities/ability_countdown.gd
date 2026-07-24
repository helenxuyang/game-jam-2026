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
	$Name.text = ability.effect_name
	
func update_ring(ability: Ability):
	$TextureProgressBar.tint_over = Color.WHITE
	var period_ms: int = ability.period * 1000
	var percent: float = 100 * float(GlobalTimer.global_ms % period_ms) / float(period_ms)
	$TextureProgressBar.value = percent

func update_label(ability: Ability):
	$Label.text = str(ability.period)

func highlight(ability: Ability):
	if ability.was_called != null:
		$TextureProgressBar.tint_over = Color.LAWN_GREEN if ability.was_called else Color.RED
	for i in range(10):
		await get_tree().process_frame
