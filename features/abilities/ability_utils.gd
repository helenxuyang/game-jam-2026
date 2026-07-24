class_name AbilityUtils

# TODO: integrate with actual function that shoots bullets
static func fire_projectile(projectile: ProjectileConfig):
	pass
	
static func get_attack_effect(projectiles: Array[ProjectileConfig]):
	for projectile in projectiles:
		fire_projectile(projectile)

static var effects: Dictionary[String, Callable] = {
	"Triple Bullet": func(): get_attack_effect([
		ProjectileConfig.new(10, Vector2(2,2), 10, 0),
		ProjectileConfig.new(10, Vector2(2,2), 10, 0.1),
		ProjectileConfig.new(10, Vector2(2,2), 10, 0.2),
	]),
	"Radial Attack": func(): get_attack_effect([
		ProjectileConfig.new(10, Vector2(1,0), 10, 0),
		ProjectileConfig.new(10, Vector2(0,1), 10, 0),
		ProjectileConfig.new(10, Vector2(-1,0), 10, 0),
		ProjectileConfig.new(10, Vector2(0,-1), 10, 0),
	]),
	"Damage Boost": func(): pass,
}

static func get_random_ability():
	var random = RandomNumberGenerator.new()
	var frequency: int = randi_range(2, 8);
	var effect_name = effects.keys().pick_random()
	var effect = effects.get(effect_name)
	return Ability.new(frequency, effect_name, effect)
