extends  Node

# TODO: integrate with actual function that shoots bullets

signal spawn_projectile(damage, direction)


func fire_projectile(projectile: ProjectileConfig):
	await get_tree().create_timer(projectile.delay).timeout
	spawn_projectile.emit(projectile.damage, projectile.direction)
	
func get_attack_effect(projectiles: Array[ProjectileConfig]):
	for projectile in projectiles:
		fire_projectile(projectile)

var effects: Array[AbilityEffect] = [
	AbilityEffect.new(
		"Triple Bullet",
		"Shoot three bullets in quick succession",
		func(): get_attack_effect([
			ProjectileConfig.new(10, 1 * Vector2.from_angle(deg_to_rad(0)), 0),
			ProjectileConfig.new(10, 1 * Vector2.from_angle(deg_to_rad(0)), 0.1),
			ProjectileConfig.new(10, 1 * Vector2.from_angle(deg_to_rad(0)), 0.2),
		])
	),
	AbilityEffect.new(
		"Radial Attack",
		"Shoot bullets up, left, right, and down",
		func(): get_attack_effect([
			ProjectileConfig.new(10, 2 * Vector2.from_angle(deg_to_rad(0)), 0),
			ProjectileConfig.new(10, 2 * Vector2.from_angle(deg_to_rad(90)), 0),
			ProjectileConfig.new(10, 2 * Vector2.from_angle(deg_to_rad(-90)), 0),
			ProjectileConfig.new(10, 2 * Vector2.from_angle(deg_to_rad(180)), 0)
		])
	),
	AbilityEffect.new(
		"Tri-Shot",
		"Shoot a spread of 3 bullets",
		func(): get_attack_effect([
			ProjectileConfig.new(10, .5 * Vector2.from_angle(deg_to_rad(0)), 0),
			ProjectileConfig.new(10, .5 * Vector2.from_angle(deg_to_rad(30)), 0),
			ProjectileConfig.new(10, .5 * Vector2.from_angle(deg_to_rad(-30)), 0),
		])
	),
	AbilityEffect.new("shotty", "Shoot a shotgun-style spray of bullets", get_shotgun_effect())
]

func get_shotgun_effect() -> Callable:
	var spread = 20
	var speedmin = .2
	var speedmax = .3
	return func(): get_attack_effect([
		ProjectileConfig.new(10, randf_range(speedmin, speedmax) * Vector2.from_angle(deg_to_rad(randi_range(-spread, spread))), 0),
		ProjectileConfig.new(10, randf_range(speedmin, speedmax) * Vector2.from_angle(deg_to_rad(randi_range(-spread, spread))), 0),
		ProjectileConfig.new(10, randf_range(speedmin, speedmax) * Vector2.from_angle(deg_to_rad(randi_range(-spread, spread))), 0),
		ProjectileConfig.new(10, randf_range(speedmin, speedmax) * Vector2.from_angle(deg_to_rad(randi_range(-spread, spread))), 0),
		ProjectileConfig.new(10, randf_range(speedmin, speedmax) * Vector2.from_angle(deg_to_rad(randi_range(-spread, spread))), 0),
		ProjectileConfig.new(10, randf_range(speedmin, speedmax) * Vector2.from_angle(deg_to_rad(randi_range(-spread, spread))), 0),
		ProjectileConfig.new(10, randf_range(speedmin, speedmax) * Vector2.from_angle(deg_to_rad(randi_range(-spread, spread))), 0),
		ProjectileConfig.new(10, randf_range(speedmin, speedmax) * Vector2.from_angle(deg_to_rad(randi_range(-spread, spread))), 0),
		ProjectileConfig.new(10, randf_range(speedmin, speedmax) * Vector2.from_angle(deg_to_rad(randi_range(-spread, spread))), 0),
	])

func get_base_attack_ability():
	return Ability.new(
		1,
		AbilityEffect.new(
			"Basic Attack",
			"Shoot a bullet",
			func(): get_attack_effect([
				ProjectileConfig.new(10, Vector2.from_angle(deg_to_rad(0)), 0)
			])
		)
	)
	
func get_random_ability():
	var periods = range(2,8);
	var period: int = periods.pick_random()
	var effect = effects.pick_random()
	return Ability.new(period, effect)
