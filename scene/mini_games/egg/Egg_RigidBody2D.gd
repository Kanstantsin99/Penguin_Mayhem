extends RigidBody2D

var w_time = 0.65

func _ready():
	get_tree().create_timer(w_time).timeout.connect(_on_timer_timeout)
	

func _on_timer_timeout():
	self.freeze = false
