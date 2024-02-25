extends RigidBody2D

var w_time:int = 0.65

func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = w_time
	timer.one_shot = true
	timer.start()
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	self.freeze = false
