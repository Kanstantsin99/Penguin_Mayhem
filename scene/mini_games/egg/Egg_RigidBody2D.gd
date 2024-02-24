extends RigidBody2D

func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.one_shot = true
	timer.start()
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	self.freeze = false
