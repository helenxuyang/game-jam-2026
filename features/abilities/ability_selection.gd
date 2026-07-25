extends CanvasLayer

class_name AbilitySelection

@export var option_card_row: HBoxContainer
@export var loadout_card_row: HBoxContainer

func _ready():
	self.build_loadout()
	self.build_options()
	
func build_loadout():
	for i in range(AbilitiesManager.abilities.size()):
		var ability = AbilitiesManager.abilities[i]
		var card = AbilityCard.create_loadout_card(ability, i > 0)
		#card.set_position(Vector2(100 + 180 * i, 100))
		card.set_content(ability)
		loadout_card_row.add_child(card)

func build_options():
	var options: Array[Ability]
	for i in range(4):
		var ability = AbilityUtils.get_random_ability()
		options.append(ability)
		var card = AbilityCard.create_option_card(ability)
		# card.set_position(Vector2(100 + 180 * i, 100))
		card.set_content(ability)
		option_card_row.add_child(card)
