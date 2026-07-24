extends Node

var abilities: Array[Ability]

func _ready():
	# temporarily add abilities to start with for testing
		
	for i in range(4):
		var ability = AbilityUtils.get_random_ability()
		self.abilities.append(ability)
		prints(ability.effect_name, ability.frequency)
	
func increment_abilities():
	for ability in self.abilities:
		ability.increment_count()
