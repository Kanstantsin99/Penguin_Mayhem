extends Node

	


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		GlobalAudioPlayer._play("res://assets/audio/select.wav")
		get_parent().screen_transition.transition()
		await get_parent().screen_transition.transition_halfway
		get_parent().switch_scene("res://scene/ui/main_menu.tscn")
