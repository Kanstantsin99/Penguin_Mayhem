extends Node


@onready var animated_sprite_2d: AnimatedSprite2D = $Node2D/AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.play("default")
	animated_sprite_2d.animation_finished.connect(on_animation_finished)


func on_animation_finished():
	get_parent().screen_transition.transition()
	await get_parent().screen_transition.transition_halfway
	get_parent().switch_scene("res://scene/ui/intro_banner.tscn")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		on_animation_finished()
