extends Node

signal result(bool)

@export var window_to_slice: float = 3

var difficulty: int = 1
var arrows: Array = ["N", "n", "m", "M"]
var players_input: Array = []
var is_sliced: bool = false
var is_correct: bool = true
var is_first_time: bool = true

@onready var scene_timer: Timer = $SceneTimer
@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar
@onready var label_1: Label = $Node2D/Panel1/Label1
@onready var label_2: Label = $Node2D/Panel2/Label2
@onready var label_3: Label = $Node2D/Panel3/Label3
@onready var label_4: Label = $Node2D/Panel4/Label4
@onready var penguin: AnimatedSprite2D = $Node2D/Penguin


func _ready() -> void:
	scene_timer.timeout.connect(_on_scene_ended)
	penguin.frame_changed.connect(_on_frame_changed)
	arrows.shuffle()
	label_1.text = arrows[0]
	label_2.text = arrows[1]
	label_3.text = arrows[2]
	label_4.text = arrows[3]
	penguin.play("default")


func _process(_delta: float) -> void:
	progress_bar.value = scene_timer.time_left


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		players_input.append("N")
		timer_start()
	elif event.is_action_pressed("ui_down"):
		players_input.append("n")
		timer_start()
	elif event.is_action_pressed("ui_left"):
		players_input.append("m")
		timer_start()
	elif event.is_action_pressed("ui_right"):
		players_input.append("M")
		timer_start()
	
	if event is InputEventKey and is_correct and !is_sliced:
		input_check()


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
		get_tree().create_timer(window_to_slice * difficulty * 1/2).timeout.connect(_on_time_out)
		is_first_time = false


func slice():
	is_sliced = true
	hide_labels()
	penguin.play("sliced")


func fail():
	is_correct = false
	hide_labels()
	penguin.play("failed")


func hide_labels():
	$Node2D/Panel1.hide()
	$Node2D/Panel2.hide()
	$Node2D/Panel3.hide()
	$Node2D/Panel4.hide()


func _on_time_out():
	if !is_sliced:
		fail()


func _on_frame_changed():
	if penguin.frame == 3:
		GlobalAudioPlayer._play("res://assets/audio/hit2.wav")


func _on_scene_ended():
	if penguin.is_playing():
		await penguin.animation_finished
	result.emit(is_sliced)
