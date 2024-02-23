extends CanvasLayer

signal showed

var lives: int
@onready var texture_progress_bar: TextureProgressBar = $Node2D/TextureProgressBar


func show_result(lives_left: int):
	lives = lives_left
	visible = true
	texture_progress_bar.value = lives
	await get_tree().create_timer(3).timeout
	visible = false
	showed.emit()
