extends CharacterBody2D


@export var speed = 100
const JUMP_VELOCITY = -200.0

var random_start: float = randf_range(1, 2)
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_sliding: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	slide()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()


func slide():
	await get_tree().create_timer(1).timeout
	if !is_sliding:
		animated_sprite_2d.play("slide")
		is_sliding = true
	
	await get_tree().create_timer(random_start).timeout
	velocity.x = -1 * speed
