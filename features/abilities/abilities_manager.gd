extends Node

const AbilitySelection = preload("res://features/abilities/ability_selection.tscn")
const MAX_NUM_ABILITIES = 4

var abilities: Array[Ability]
var audio_players: Array[AudioStreamPlayer]

func _ready() -> void:
	self.abilities.append(AbilityUtils.get_base_attack_ability())
	self.add_ability_countdown_audio_players()
	Hud.build_ability_countdowns()
	
func add_ability(ability: Ability):
	abilities.append(ability)
	Hud.build_ability_countdowns()

func play_audio_cue(ability: Ability, ability_index: int):
	var countdown = Hud.ability_countdowns[ability_index]
	var audio_player = self.audio_players[ability_index]
	
	var period_ms = ability.period * 1000
	var closest_multiple = snappedi(GlobalTimer.global_ms, period_ms)
	var diff = closest_multiple - GlobalTimer.global_ms
	if diff > 0 && diff <= 20:
		if !ability.was_called:
			audio_player.pitch_scale = 1
			audio_player.play();
		ability.was_called = false
	# quarter note pickup
	elif diff >= 240 && diff <= 260:
		audio_player.pitch_scale = 0.80
		audio_player.finished.connect(func(): audio_player.pitch_scale = 1)
		# audio_player.play()
	
func update_ability_countdowns():
	for i in self.abilities.size():
		var ability = self.abilities[i]
		var countdown = Hud.ability_countdowns[i]
		if !GlobalTimer.is_paused:
			countdown.update_ring(ability)
			self.play_audio_cue(ability, i)
			
			
func handle_fire():
	if !GlobalTimer.is_paused:
		for i in range(self.abilities.size()):
			var ability = self.abilities[i]
			var countdown = Hud.ability_countdowns[i]
			var successful = ability.fire()
			countdown.highlight(successful)
			if successful:
				$FireSoundPlayer.play()
				var audio_player = self.audio_players[i]
				audio_player.pitch_scale = 1
				audio_player.play();
	GlobalTimer.pause()
	
	
func add_ability_countdown_audio_players():
	for i in range(MAX_NUM_ABILITIES):
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
		if (sec == 0 || sec % ability.period == 0):
			# audio_player.play();
			pass
