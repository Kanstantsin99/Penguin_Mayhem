extends CharacterBody2D


@export var speed = 20.0
const JUMP_VELOCITY = -200.0

var random_start: int = randi_range(1, 3)
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	await get_tree().create_timer(random_start).timeout
	velocity.x = -1 * speed

	move_and_slide()
