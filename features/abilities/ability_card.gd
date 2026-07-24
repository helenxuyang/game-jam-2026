class_name AbilityCard
extends Control

static func create(ability: Ability):
	var scene = load("res://features/abilities/ability_card.tscn")
	var instance: AbilityCard = scene.instantiate()
	return instance

func set_content(ability: Ability):
	$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/NameLabel.text = ability.effect.name
	$PanelContainer/MarginContainer/VBoxContainer/DescriptionLabel.text = ability.effect.description
	$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/PeriodLabel.text = str(ability.period)
	$PanelContainer/MarginContainer/VBoxContainer/SelectButton.pressed.connect(func(): select_ability(ability))
	
func select_ability(ability):
	AbilitiesManager.add_ability(ability)
	SceneManager.show_combat_scene()
	
