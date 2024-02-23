extends CanvasLayer

signal transition_halfway;

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect


func transition():
	show()
	animation_player.play("default")
	await animation_player.animation_finished
	transition_halfway.emit()
	animation_player.play_backwards("default")
	await animation_player.animation_finished
	hide()

func transition_in():
	show()
	animation_player.play("default")
	await animation_player.animation_finished
	transition_halfway.emit()
	hide()


func transition_out():
	show()
	animation_player.play_backwards("default")
	await animation_player.animation_finished
	transition_halfway.emit()
	hide()
