extends Node


func _queue_free():
	get_parent().switch_scene("res://scene/ui/main_menu.tscn")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		_queue_free()
