extends Node


func _queue_free():
	get_parent().screen_transition.transition()
	await get_parent().screen_transition.transition_halfway
	get_parent().switch_scene("res://scene/ui/intro.tscn")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		_queue_free()
