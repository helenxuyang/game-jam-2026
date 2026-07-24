class_name AbilityCountdown
extends Control

var ability: Ability

static func create(ability: Ability):
	var scene = load("res://features/abilities/ability_countdown.tscn")
	var instance: AbilityCountdown = scene.instantiate()
	instance.ability = ability
	instance.get_node("Label").text = str(ability.frequency)
	instance.update_count_display()
	
	GlobalCounter.count_sec.connect(instance.on_count_sec)
	player.fire.connect(instance.on_fire)
	
	return instance

func on_count_sec():
	self.ability.increment_count()
	self.update_count_display()

func on_fire():
	self.ability.fire()
	self.update_count_display()
	
func update_count_display():
	var percent = float(self.ability.current_count) / float(self.ability.frequency) * 100
	set_value(percent)
	$Label.text = str(self.ability.current_count) + "/" + str(self.ability.frequency)
	
func set_value(value):
	$TextureProgressBar.value = value
