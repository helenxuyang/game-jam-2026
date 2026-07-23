extends Control

var ability: Ability

func _init(ability):
	self.ability = ability
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

func set_value(value):
	$TextureProgressBar.value = value
