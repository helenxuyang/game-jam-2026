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
	var percent = float(self.ability.current_count) / float(self.ability.frequency) * 100
	$TextureProgressBar.value = percent

func update_label():
	$Label.text = str(self.ability.frequency)

func highlight():
	$TextureProgressBar.tint_over = Color.LAWN_GREEN
	for i in range(10):
		await get_tree().process_frame
	$TextureProgressBar.tint_over = Color.WHITE
