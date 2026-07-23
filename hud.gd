extends CanvasLayer

func noop(): 
    pass
    
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    var ability = Ability.new(5, noop)
    var ability_countdown = AbilityCountdown.create(ability)
    ability_countdown.set_position(Vector2(100, 100))
    add_child(ability_countdown)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
