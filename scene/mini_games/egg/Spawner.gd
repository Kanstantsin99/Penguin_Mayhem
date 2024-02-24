extends Node2D

var egg = preload("res://scene/mini_games/egg/egg_rb.tscn")
var rng = RandomNumberGenerator.new()
var amount: int
var max: int

@onready var main = $".."

var objectarray = []

func _ready():
	#objectarray = null
	amount = 0
	max = main.difficulty + 2
	timer()

func timer():
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1 / main.difficulty
	timer.one_shot = true
	timer.start()
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	if amount < max:
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
