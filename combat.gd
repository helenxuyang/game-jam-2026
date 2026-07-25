extends Node2D

const enemy = preload("res://enemy.tscn")

var enemies: Array[Enemy] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.setup_enemies(3)
	GlobalTimer.timer.start()
	GlobalTimer.metronome_timer.start()
	GlobalTimer.count_sec.connect(func(): $MetronomeAudioStreamPlayer.play(0.04))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# remove freed enemies
	self.enemies = self.enemies.filter(func(enemy): return enemy != null)
	if self.enemies.size() == 0:
		SceneManager.show_ability_selection()
	

func get_random_enemy_position() -> Vector2:
	var radius = 50
	var random_x_half = randi() % 2
	var random_y_half = randi() % 2
	var x = randi_range(0, player.position.x + radius) if random_x_half == 0 else randi_range(player.position.x + radius, get_viewport().size.x)
	var y = randi_range(0, player.position.y + radius) if random_y_half == 0 else randi_range(player.position.y + radius, get_viewport().size.y)
	return Vector2(x, y)
	
func add_enemy(enemy: Enemy):
	enemy.global_position = get_random_enemy_position()
	add_child(enemy)

func setup_enemies(num: int):
	self.enemies = []
	for i in range(num):
		var enemy_creator: Callable = Enemy.enemy_creators.pick_random()
		var enemy: Enemy = enemy_creator.call()
		self.enemies.append(enemy)
		add_enemy(enemy)
