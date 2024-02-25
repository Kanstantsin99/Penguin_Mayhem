extends Node

signal result(bool)

@onready var scene_timer: Timer = $SceneTimer
@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar
@onready var circle = $Circle
@onready var aaa = $Aaa
@onready var player = $Player
@onready var area_2d_circle = $Circle/Area2D

var difficulty = 1
var rotate: bool = true
var norm: bool = false
var enter: bool = false

func _ready():
	scene_timer.timeout.connect(_on_scene_ended)
	player.play("idle")
	area_2d_circle.area_entered.connect(_on_area_2d_area_entered)
	area_2d_circle.area_exited.connect(_on_area_2d_area_exited)

func _process(delta):
	if rotate:
		circle.rotation_degrees = (circle.rotation_degrees + 40 * (difficulty * 0.25))
	progress_bar.value = scene_timer.time_left
	if Input.is_action_just_pressed("ui_accept"):
		rotate = false
		player.play("attack")
		aaa.visible = true
		aaa.play("aaa")
		if enter:
			norm = true
			GlobalAudioPlayer._play("res://assets/audio/shot.wav")
			#print("win")
		else:
			norm = false
			GlobalAudioPlayer._play("res://assets/audio/hit2.wav")
			#print("loose")

func _on_area_2d_area_entered(area):
	enter = true

func _on_area_2d_area_exited(area):
	enter = false

func _on_scene_ended():
	result.emit(norm)
