extends  Node

# TODO: integrate with actual function that shoots bullets

signal spawn_projectile(damage, direction)


func fire_projectile(projectile: ProjectileConfig):
	await get_tree().create_timer(projectile.delay).timeout
	spawn_projectile.emit(projectile.damage, projectile.direction)
	
func get_attack_effect(projectiles: Array[ProjectileConfig]):
	for projectile in projectiles:
		fire_projectile(projectile)

var effects: Dictionary[String, Callable] = {
	"Triple Bullet": func(): get_attack_effect([
		ProjectileConfig.new(10, 1 * Vector2.from_angle(deg_to_rad(0)), 0),
		ProjectileConfig.new(10, 1 * Vector2.from_angle(deg_to_rad(0)), 0.1),
		ProjectileConfig.new(10, 1 * Vector2.from_angle(deg_to_rad(0)), 0.2),
	]),
	"Radial Attack": func(): get_attack_effect([
		ProjectileConfig.new(10, 2 * Vector2.from_angle(deg_to_rad(0)), 0),
		ProjectileConfig.new(10, 2 * Vector2.from_angle(deg_to_rad(90)), 0),
		ProjectileConfig.new(10, 2 * Vector2.from_angle(deg_to_rad(-90)), 0),
		ProjectileConfig.new(10, 2 * Vector2.from_angle(deg_to_rad(180)), 0)
	]),
	"Tri-Shot": func(): get_attack_effect([
		ProjectileConfig.new(10, .5 * Vector2.from_angle(deg_to_rad(0)), 0),
		ProjectileConfig.new(10, .5 * Vector2.from_angle(deg_to_rad(30)), 0),
		ProjectileConfig.new(10, .5 * Vector2.from_angle(deg_to_rad(-30)), 0),
	]),
	"shotty": func(): 
		var spread = 20
		var speedmin = .2
		var speedmax = .3
		get_attack_effect([
		ProjectileConfig.new(10, randf_range(speedmin, speedmax) * Vector2.from_angle(deg_to_rad(randi_range(-spread, spread))), 0),
		ProjectileConfig.new(10, randf_range(speedmin, speedmax) * Vector2.from_angle(deg_to_rad(randi_range(-spread, spread))), 0),
		ProjectileConfig.new(10, randf_range(speedmin, speedmax) * Vector2.from_angle(deg_to_rad(randi_range(-spread, spread))), 0),
		ProjectileConfig.new(10, randf_range(speedmin, speedmax) * Vector2.from_angle(deg_to_rad(randi_range(-spread, spread))), 0),
		ProjectileConfig.new(10, randf_range(speedmin, speedmax) * Vector2.from_angle(deg_to_rad(randi_range(-spread, spread))), 0),
		ProjectileConfig.new(10, randf_range(speedmin, speedmax) * Vector2.from_angle(deg_to_rad(randi_range(-spread, spread))), 0),
		ProjectileConfig.new(10, randf_range(speedmin, speedmax) * Vector2.from_angle(deg_to_rad(randi_range(-spread, spread))), 0),
		ProjectileConfig.new(10, randf_range(speedmin, speedmax) * Vector2.from_angle(deg_to_rad(randi_range(-spread, spread))), 0),
		ProjectileConfig.new(10, randf_range(speedmin, speedmax) * Vector2.from_angle(deg_to_rad(randi_range(-spread, spread))), 0),
	]),
	#"Damage Boost": func(): pass,
}

func get_random_ability():
	var random = RandomNumberGenerator.new()
	var frequency: int = randi_range(2, 8);
	var effect_name = effects.keys().pick_random()
	var effect = effects.get(effect_name)
	return Ability.new(frequency, effect_name, effect)
