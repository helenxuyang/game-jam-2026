extends Node

var abilities: Array[Ability]

func _ready():
	# temporarily add abilities to start with for testing
	for i in range(4):
		var ability = AbilityUtils.get_random_ability()
		self.abilities.append(ability)
		prints(ability.effect_name, ability.frequency)
	GlobalCounter.count_sec.connect(increment_abilities)
	
func increment_abilities():
	for ability in self.abilities:
		ability.increment_count()
	Hud.update_display()
	
func fire_abilities():
	for ability in self.abilities:
		ability.fire()
	GlobalCounter.reset_time()
	Hud.update_display()
