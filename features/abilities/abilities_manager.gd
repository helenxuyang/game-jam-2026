extends Node

var abilities: Array[Ability]
var audio_players: Array[AudioStreamPlayer]

func _ready() -> void:
	# temporarily add abilities to start with for testing
	for i in range(4):
		var ability = AbilityUtils.get_random_ability()
		self.abilities.append(ability)
		prints(ability.effect_name, ability.period)
	Hud.build_ability_countdowns()
	self.add_ability_countdown_audio_players()

func handle_fire():
	if !GlobalTimer.is_paused:
		for i in range(self.abilities.size()):
			var ability = self.abilities[i]
			if ability.fire():
				# make sure audio still plays even if you clicked early
				var audio_player = self.audio_players[i]
				if !audio_player.playing:
					audio_player.play()
	GlobalTimer.pause()

func add_ability_countdown_audio_players():
	for i in range(self.abilities.size()):
		var ability = self.abilities[i]
		var audio_player = AudioStreamPlayer.new()
		var cOctave = i + 2
		audio_player.stream = load("res://sound/C" + str(cOctave) + ".mp3")
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
