extends Area2D
var screen_size # Size of the game window.
var speed = 400
const Bullet = preload("res://bullet.tscn")
var dodging = 0
var velocity = Vector2.ZERO # The player's movement vector.

var max_health = 50.0
var health = max_health

var dodge_dir = Vector2.ZERO
var dodge_speed = 3
var dodge_time = 0.25
var dodge_cooldown = 0.5


@onready var dodge_timer = $DodgeTimer
@onready var dodge_cooldown_timer = $DodgeCooldown

signal fire

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size # Replace with function body.
	AbilityUtils.spawn_projectile.connect(_on_spawn_projectile)
	dodge_timer.wait_time = dodge_time
	dodge_cooldown_timer.wait_time = dodge_cooldown
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2.ZERO
	if !dodging:
		if Input.is_action_pressed("move_right"):
			velocity.x = 1
		if Input.is_action_pressed("move_left"):
			velocity.x = -1
		if Input.is_action_pressed("move_down"):
			velocity.y = 1
			#rotation_degrees += 1
		if Input.is_action_pressed("move_up"):
			velocity.y = -1
			#rotation_degrees -= 1
		if Input.is_action_just_pressed("fire"):
			AbilitiesManager.handle_fire()
			
		velocity = velocity.normalized() * speed
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)
		look_at(get_global_mouse_position())
	else:
		velocity = dodge_dir.normalized() * speed * dodge_speed *  clampf(dodge_timer.time_left/dodge_time + .5, 0, 1)
		position += velocity * delta
		look_at(get_global_mouse_position())


func _input(event):
	if event.is_action_pressed("dodge"):
		if dodge_cooldown_timer.is_stopped() and !dodging:
			dodging = 1
			dodge_dir = Vector2.ZERO
			if Input.is_action_pressed("move_right"):
				dodge_dir.x = 1
			if Input.is_action_pressed("move_left"):
				dodge_dir.x = -1
			if Input.is_action_pressed("move_down"):
				dodge_dir.y = 1
				#rotation_degrees += 1
			if Input.is_action_pressed("move_up"):
				dodge_dir.y = -1
			dodge_dir = dodge_dir.normalized()
			dodge_timer.start()
			await dodge_timer.timeout
			dodging = 0
			dodge_cooldown_timer.start()
		
		
func _on_spawn_projectile(damage, direction) -> void:
	var bullet =  Bullet.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = global_position
	bullet.global_rotation = global_rotation + direction.angle()
	bullet.speed = bullet.speed * direction.length()
	bullet.damage = damage
