class_name AbilityCard
extends Control

@export var name_label: Label
@export var description_label: Label
@export var period_label: Label
@export var select_button: Button
@export var delete_button: Button

static func create_option_card(ability: Ability):
	var scene = load("res://features/abilities/ability_card.tscn")
	var instance: AbilityCard = scene.instantiate()
	instance.delete_button.hide()
	instance.select_button.show()
	if AbilitiesManager.abilities.size() == AbilitiesManager.MAX_NUM_ABILITIES:
		instance.select_button.disabled = true
	return instance

static func create_loadout_card(ability: Ability, can_delete: bool = true):
	var scene = load("res://features/abilities/ability_card.tscn")
	var instance: AbilityCard = scene.instantiate()
	instance.select_button.hide()
	if can_delete:
		instance.delete_button.show()
	else:
		instance.delete_button.hide()
	return instance

func set_content(ability: Ability):
	name_label.text = ability.effect.name
	description_label.text = ability.effect.description
	period_label.text = str(ability.period)
	select_button.pressed.connect(func(): select_ability(ability))
	
func select_ability(ability):
	AbilitiesManager.add_ability(ability)
	SceneManager.show_combat_scene()

func delete_ability(index: int):
	AbilitiesManager.abilities.remove_at(index)
	
