extends Node

@onready var start_button: Button = $Node2D/MarginContainer/VBoxContainer/StartButton
@onready var exit_button: Button = $Node2D/MarginContainer/VBoxContainer/ExitButton


func _ready() -> void:
	start_button.pressed.connect(_on_start)
	exit_button.pressed.connect(_on_exit)
	start_button.grab_focus()


func _on_start():
	get_parent()._on_result(true)
	GlobalAudioPlayer._play("res://assets/audio/select.wav")


func _on_exit():
	get_tree().quit()
