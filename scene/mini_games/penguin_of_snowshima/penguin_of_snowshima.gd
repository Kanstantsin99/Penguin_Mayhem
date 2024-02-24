extends Node

signal result(bool)

@export var window_to_slice = 3

var difficulty: int = 1
var arrows: Array = ["↑", "↓", "←", "→"]
var players_input: Array = []
var is_sliced: bool = false
var is_correct: bool = true
var is_first_time: bool = true

@onready var scene_timer: Timer = $SceneTimer
@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar
@onready var label_1: Label = $Node2D/Label1
@onready var label_2: Label = $Node2D/Label2
@onready var label_3: Label = $Node2D/Label3
@onready var label_4: Label = $Node2D/Label4


func _ready() -> void:
	scene_timer.timeout.connect(_on_scene_ended)
	arrows.shuffle()
	label_1.text = arrows[0]
	label_2.text = arrows[1]
	label_3.text = arrows[2]
	label_4.text = arrows[3]


func _process(delta: float) -> void:
	progress_bar.value = scene_timer.time_left


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		players_input.append("↑")
	elif event.is_action_pressed("ui_down"):
		players_input.append("↓")
	elif event.is_action_pressed("ui_left"):
		players_input.append("←")
	elif event.is_action_pressed("ui_right"):
		players_input.append("→")
	
	if event is InputEventKey and is_correct and !is_sliced:
		input_check()
		timer_start()


func input_check():
	if players_input.size() > 0 and players_input.size() <= arrows.size():
		for i in range(players_input.size()):
			if players_input[i] != arrows[i]:
				fail()
				return
		if players_input.size() == arrows.size():
			slice()


func timer_start():
	if is_first_time:
		get_tree().create_timer(window_to_slice * 1/difficulty).timeout.connect(_on_time_out)
		is_first_time = false


func slice():
	is_sliced = true
	print("Sliced")


func fail():
	is_correct = false
	print("Failed")


func _on_time_out():
	if !is_sliced:
		fail()


func _on_scene_ended():
	result.emit(is_sliced)
