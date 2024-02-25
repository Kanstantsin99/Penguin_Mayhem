extends Node

signal result(bool)

@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar
@onready var scene_timer: Timer = $SceneTimer
@onready var area_2d = $player/Area2D
@onready var player = $player
@onready var player_2 = $Player2
@onready var egg_rigid_body_2d = $Egg_RigidBody2D

var difficulty = 1
var res:bool = false
var can:bool = false
var click:bool = false

func _ready():
	player.play("idle")
	scene_timer.timeout.connect(_on_scene_ended)
	area_2d.body_entered.connect(_body_entered)
	area_2d.body_exited.connect(_body_exited)
	egg_rigid_body_2d.gravity_scale = (0.05 * difficulty)
	pass 

func _body_entered(node):
	can = true

func _body_exited(node):
	can = false

func _process(delta):
	progress_bar.value = scene_timer.time_left
	if !click:
		if Input.is_action_just_pressed("ui_accept"):
			click = true
			player.play("catch")
			player_2.visible = true
			if can:
				GlobalAudioPlayer._play("res://assets/audio/shot.wav")
				res = true
				egg_rigid_body_2d.gravity_scale = 0
				egg_rigid_body_2d.freeze = true
			else:
				GlobalAudioPlayer._play("res://assets/audio/hit2.wav")
				res = false

func _on_scene_ended():
	result.emit(res)
