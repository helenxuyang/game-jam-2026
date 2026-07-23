extends Area2D
var screen_size # Size of the game window.


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 100
	if Input.is_action_pressed("move_left"):
		velocity.x -= 100
	if Input.is_action_pressed("move_down"):
		rotation_degrees += 1
	if Input.is_action_pressed("move_up"):
		rotation_degrees -= 1
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
