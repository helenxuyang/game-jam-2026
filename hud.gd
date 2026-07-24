extends CanvasLayer

var total_label: Label
var ability_countdowns: Array[AbilityCountdown]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.ability_countdowns = []
	for i in Loadout.abilities.size():
		var ability = Loadout.abilities[i]
		var ability_countdown = AbilityCountdown.create(ability)
		ability_countdown.set_position(Vector2(100 + 80 * i, 100))
		self.ability_countdowns.append(ability_countdown)
		add_child(ability_countdown)
		
	self.total_label = Label.new()
	self.total_label.set_position(Vector2(0, 100))
	add_child(self.total_label)

	update_ability_ring_displays()
		
func update_ability_ring_displays():
	for ability_countdown in self.ability_countdowns:
		if GlobalCounter.is_paused:
			ability_countdown.highlight()
		else:
			ability_countdown.update_ring()

func handle_fire():
	#var is_on_time = GlobalCounter.global_ms % 1000 <= GlobalCounter.valid_window
	#prints("on time", is_on_time)
	if !GlobalCounter.is_paused:
		for ability_countdown in self.ability_countdowns:
			ability_countdown.ability.fire()
	GlobalCounter.pause()
