extends CanvasLayer

@export var duration: float = 1

@onready var label: Label = $Node2D/MarginContainer/Label

func _ready() -> void:
	hide()


func show_guidance(guidance: String):
	get_tree().paused = true
	show()
	label.text = guidance
	await get_tree().create_timer(duration).timeout
	hide()
	get_tree().paused = false
