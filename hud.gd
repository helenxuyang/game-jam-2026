extends CanvasLayer

var total_label: Label
var ability_countdowns: Array[AbilityCountdown]
	
func build_ability_countdowns():
	self.clear_children()
	for i in AbilitiesManager.abilities.size():
		var ability = AbilitiesManager.abilities[i]
		var countdown = AbilityCountdown.create(ability)
		countdown.set_position(Vector2(100 + 80 * i, 100))
		self.ability_countdowns.append(countdown)
		self.add_child(countdown)
	self.update_ability_ring_displays()

func clear_children():
	var children = self.get_children()
	for child in children:
		child.free()

func update_ability_ring_displays():
	for i in AbilitiesManager.abilities.size():
		var ability = AbilitiesManager.abilities[i]
		var countdown = ability_countdowns[i]
		if GlobalTimer.is_paused:
			countdown.highlight(ability)
		else:
			countdown.update_ring(ability)
	
