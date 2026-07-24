extends CanvasLayer

var total_label: Label
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in Loadout.abilities.size():
		var ability = Loadout.abilities[i]
		var ability_countdown = AbilityCountdown.create(ability)
		ability_countdown.set_position(Vector2(100 + 80 * i, 100))
		add_child(ability_countdown)
		
		self.total_label = Label.new()
		GlobalCounter.count_sec.connect(self.update_total_label)
		self.total_label.set_position(Vector2(0, 100))
		add_child(self.total_label)

func update_total_label():
	self.total_label.text = str(roundf(GlobalCounter.global_time))
