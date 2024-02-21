extends Node


func _queue_free():
	get_parent().switch_scene("res://scene/ui/main_menu.tscn")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		_queue_free()
