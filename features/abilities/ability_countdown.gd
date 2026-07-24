class_name AbilityCountdown
extends Control

var ability: Ability

static func create(ability: Ability):
	var scene = load("res://features/abilities/ability_countdown.tscn")
	var instance: AbilityCountdown = scene.instantiate()
	instance.ability = ability
	instance.update_display()
	return instance

	
func update_display():
	var percent = float(self.ability.current_count) / float(self.ability.frequency) * 100
	set_value(percent)
	$Label.text = str(self.ability.current_count) + "/" + str(self.ability.frequency)
	
func set_value(value):
	$TextureProgressBar.value = value
