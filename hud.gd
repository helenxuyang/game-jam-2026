extends CanvasLayer

func noop(): 
	pass
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(4):
		var ability = AbilityUtils.get_random_ability()
		var ability_countdown = AbilityCountdown.create(ability)
		ability_countdown.set_position(Vector2(100 + 80 * i, 100))
		add_child(ability_countdown)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
