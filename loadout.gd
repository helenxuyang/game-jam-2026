extends Node

var abilities: Array[Ability]

func _ready():
	# temporarily add abilities to start with for testing
	for i in range(4):
		var ability = AbilityUtils.get_random_ability()
		self.abilities.append(ability)
