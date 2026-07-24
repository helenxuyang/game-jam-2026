class_name ProjectileConfig

var damage: int
var direction: Vector2
var speed: float
var delay: float # e.g. shoot multiple bullets
	
func _init(damage, direction, speed, delay = 0.0):
	self.damage = damage
	self.direction = direction
	self.speed = speed
	self.delay = delay
