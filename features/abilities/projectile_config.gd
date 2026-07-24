class_name ProjectileConfig

var damage: int
var direction: Vector2
var delay: float # e.g. shoot multiple bullets
	
func _init(damage, direction, delay = 0.0):
	self.damage = damage
	self.direction = direction
	self.delay = delay
