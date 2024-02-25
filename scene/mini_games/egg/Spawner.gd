extends Node2D

var egg = preload("res://scene/mini_games/egg/egg_rb.tscn")
var rng = RandomNumberGenerator.new()
var amount: int
var max_val: int

@onready var main = $".."

var objectarray = []

func _ready():
	#objectarray = null
	amount = 0
	max_val = main.difficulty + 1
	spawn()

func timer():
	var my_timer = Timer.new()
	add_child(my_timer)
	my_timer.wait_time = 0.75 #/ main.difficulty
	my_timer.one_shot = true
	my_timer.start()
	my_timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	if amount < max_val:
		spawn()

func spawn():
	var obj
	obj = egg.instantiate()
	var x = rng.randf_range(5, 80)
	obj.position = Vector2(x, 6)
	add_child(obj)
	objectarray.append(obj)
	timer()
	print("spawn")
	amount = amount + 1
