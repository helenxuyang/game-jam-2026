extends Area2D
var screen_size # Size of the game window.
var speed = 400
const Bullet = preload("res://bullet.tscn")

signal fire

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size # Replace with function body.
	AbilityUtils.spawn_projectile.connect(_on_spawn_projectile)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		#rotation_degrees += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		#rotation_degrees -= 1
	if Input.is_action_just_pressed("fire"):
		Hud.handle_fire()
		
	velocity = velocity.normalized() * speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	look_at(get_global_mouse_position())
	
func _on_spawn_projectile(damage, direction) -> void:
	var bullet =  Bullet.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = global_position
	bullet.global_rotation = global_rotation + direction.angle()
	bullet.speed = bullet.speed * direction.length()
