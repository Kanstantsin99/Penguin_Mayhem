extends CharacterBody2D

signal player_died

const JUMP_VELOCITY = -200

var is_alive: bool = true
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var hit_box: Area2D = $HitBox
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	hit_box.body_entered.connect(_on_hit)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() or Input.is_action_just_pressed("ui_up") and is_on_floor():
		if is_alive:
			velocity.y = JUMP_VELOCITY
			animated_sprite_2d.play("jump")
			GlobalAudioPlayer._play("res://scene/mini_games/crazy_car/jump.wav")
	
	move_and_slide()


func _on_hit(_body):
	is_alive = false
	GlobalAudioPlayer._play("res://assets/audio/hit2.wav")
	animated_sprite_2d.play("death")
