extends CanvasLayer

signal showed

var score_val: int = 0
var lives: int
@onready var texture_progress_bar: TextureProgressBar = $Node2D/TextureProgressBar
@onready var Score: Label = $Node2D/Score


func show_result(lives_left: int):
	lives = lives_left
	visible = true
	texture_progress_bar.value = lives
	Score.text = str(score_val)
	score_val += 1
	await get_tree().create_timer(3).timeout
	visible = false
	showed.emit()
