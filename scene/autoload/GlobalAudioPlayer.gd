extends AudioStreamPlayer


func _play(_name: String):
	stream = load(_name)
	play()
