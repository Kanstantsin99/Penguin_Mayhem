extends Node

@onready var start_button: Button = $Node2D/MarginContainer/VBoxContainer/StartButton
@onready var exit_button: Button = $Node2D/MarginContainer/VBoxContainer/ExitButton

#BUG: Grab focus doesn't provide UI control by arrows when istantiating the scene 
func _ready() -> void:
	start_button.pressed.connect(_on_start)
	exit_button.pressed.connect(_on_exit)
	start_button.grab_focus()


func _on_start():
	print("Start pressed")
	get_parent().switch_scene("res://scene/mini_games/crazy_cars/crazy_car.tscn")

func _on_exit():
	print("Exit pressed")
	get_tree().quit()

# Временная функция 
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		_on_start()
