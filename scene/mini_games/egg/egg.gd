extends Node

signal result(bool)

@onready var scene_timer: Timer = $SceneTimer
@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar
@onready var character_body_2d = $CharacterBody2D

var difficulty = 1
var norm: bool = false
var count: int = 0


func _ready():
	scene_timer.timeout.connect(_on_scene_ended)

func _process(delta):
	progress_bar.value = scene_timer.time_left
	
func _catch():
	count = count + 1
	
func _on_scene_ended():
	if count == difficulty:
		norm = true
	else:
		norm = false
	result.emit(norm)
