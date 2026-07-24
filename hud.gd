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

	update_display()
		
func update_total_label_display():
	self.total_label.text = str(int(roundf(GlobalCounter.global_time)))
	
func update_ability_countdown_displays():
	for ability_countdown in self.ability_countdowns:
		ability_countdown.update_display()
	
func update_display():
	self.update_total_label_display()
	self.update_ability_countdown_displays()
	
