extends CanvasLayer

class_name AbilitySelection

func _ready():
	self.build_ability_cards()
	
func build_ability_cards():
	var options: Array[Ability]
	for i in range(4):
		var ability = AbilityUtils.get_random_ability()
		options.append(ability)
		var card = AbilityCard.create(ability)
		card.set_position(Vector2(100 + 180 * i, 100))
		card.set_content(ability)
		$CenterContainer/VBoxContainer/GridContainer.add_child(card)
