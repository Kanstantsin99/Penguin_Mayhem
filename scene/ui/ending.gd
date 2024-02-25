extends Node

var is_pressed: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $Node2D/AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var start_button: Button = $Node2D/VBoxContainer/StartButton
@onready var exit_button: Button = $Node2D/VBoxContainer/ExitButton

func _ready() -> void:
	animated_sprite_2d.play("default")
	animated_sprite_2d.animation_finished.connect(on_animation_finished)
	start_button.pressed.connect(_on_start_pressed)
	exit_button.pressed.connect(_on_exit_pressed)


func on_animation_finished():
	is_pressed = true
	animated_sprite_2d.hide()
	animation_player.play("congrats")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and !is_pressed:
		on_animation_finished()
		is_pressed = true


func _on_start_pressed():
	get_parent()._continue()


func _on_exit_pressed():
	get_tree().quit()
