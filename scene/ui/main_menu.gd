extends Node

@onready var start_button: Button = $Node2D/MarginContainer/VBoxContainer/StartButton
@onready var exit_button: Button = $Node2D/MarginContainer/VBoxContainer/ExitButton


func _ready() -> void:
	start_button.pressed.connect(_on_start)
	exit_button.pressed.connect(_on_exit)
	start_button.grab_focus()


func _on_start():
	print("Start pressed")
	get_parent().switch_scene("res://scene/mini_games/crazy_car/crazy_car.tscn")


func _on_exit():
	print("Exit pressed")
	get_tree().quit()
