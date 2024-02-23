extends Node

var players_name = ""
const alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"


@onready var h_box_container: HBoxContainer = $Node2D/MarginContainer/VBoxContainer/PanelContainer/HBoxContainer
@onready var start_button: Button = $Node2D/MarginContainer/VBoxContainer/StartButton
@onready var button: Button = $Node2D/MarginContainer/VBoxContainer/PanelContainer/HBoxContainer/Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.grab_focus()
	button.pressed.connect(_on_button_pressed)


func _on_button_pressed():
	button.focus_mode = Control.FOCUS_NONE
