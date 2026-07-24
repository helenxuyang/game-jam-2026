extends Node

const AbilitySelection = preload("res://features/abilities/ability_selection.tscn")
const NUM_ABILITIES = 4

var abilities: Array[Ability]
var audio_players: Array[AudioStreamPlayer]

func _ready() -> void:
	self.abilities.append(AbilityUtils.get_base_attack_ability())
	self.add_ability_countdown_audio_players()

func add_ability(ability: Ability):
	abilities.append(ability);
	
	
func show_ability_countdowns():
	Hud.build_ability_countdowns()
	self.add_ability_countdown_audio_players()
	
func handle_fire():
	var successful = false
	if !GlobalTimer.is_paused:
		for i in range(self.abilities.size()):
			var ability = self.abilities[i]
			if ability.fire():
				# make sure audio still plays even if you clicked early
				var audio_player = self.audio_players[i]
				audio_player.play()
				successful = true
	if !successful:
		GlobalTimer.pause()
	
func add_ability_countdown_audio_players():
	for i in range(NUM_ABILITIES):
		var audio_player = AudioStreamPlayer.new()
		var octave = i + 2
		audio_player.stream = load("res://sound/C" + str(octave) + ".mp3")
		self.audio_players.append(audio_player)
		self.add_child(audio_player)
	GlobalTimer.count_sec.connect(play_audio)

func play_audio():
	var sec: int = GlobalTimer.global_ms / 1000
	for i in range(self.abilities.size()):
		var ability = self.abilities[i]
		var audio_player = self.audio_players[i]
		if (sec % ability.period == 0):
			audio_player.play();
