extends Area2D
var speed = 20;
var speed_scale = 1;
signal hit

func _init():
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = transform.x.normalized() * speed * speed_scale # The player's movement vector.
	position += velocity #this is to make the bullet fly to the right when fired
	pass


func _on_body_entered(body: Node2D) -> void:
	hit.emit()
	set_deferred("disabled", true)
