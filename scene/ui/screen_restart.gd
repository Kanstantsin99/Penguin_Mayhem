extends CanvasLayer

var score: int = 0

@onready var start_button: Button = $VBoxContainer/StartButton
@onready var exit_button: Button = $VBoxContainer/ExitButton
@onready var your_score: Label = $YourScore

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	start_button.pressed.connect(_on_start_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)


func _show():
	show()
	your_score.text = "Your score: " + str(score - 1)
	start_button.grab_focus()


func _on_start_button_pressed():
	get_parent().restart()
	hide()


func _on_exit_button_pressed():
	get_tree().quit()
