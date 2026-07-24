class_name AbilityCountdown
extends Control

var ability: Ability

static func create(ability: Ability):
	var scene = load("res://features/abilities/ability_countdown.tscn")
	var instance: AbilityCountdown = scene.instantiate()
	instance.ability = ability
	GlobalCounter.count_sec.connect(instance.update_count)
	instance.get_node("Label").text = str(ability.frequency)
	instance.update_count()
	
	return instance

func update_count():
	self.ability.update_count()
	var percent = float(self.ability.current_count) / float(self.ability.frequency) * 100
	set_value(percent)
	
func set_value(value):
	$TextureProgressBar.value = value
