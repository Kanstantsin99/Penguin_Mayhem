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
	get_tree().create_timer(.75).timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	if amount < max_val:
		spawn()

func spawn():
	var obj
	obj = egg.instantiate()
	obj.gravity_scale = 0.5
	var x = rng.randf_range(5, 80)
	obj.position = Vector2(x, 6)
	add_child(obj)
	objectarray.append(obj)
	timer()
	print("spawn")
	amount = amount + 1
