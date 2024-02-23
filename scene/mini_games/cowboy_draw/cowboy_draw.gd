extends Node

signal result(bool)

@export_range(0,1) var squinting_time: float = 1

var player_is_alive: bool = true
var seal_is_alive: bool = true
var is_squinting: bool = false

@onready var scene_timer: Timer = $SceneTimer
@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar
@onready var player: AnimatedSprite2D = $Node2D/Player
@onready var seal: AnimatedSprite2D = $Node2D/Seal


func _ready() -> void:
	scene_timer.timeout.connect(_on_scene_ended)
	start_squint()


func _process(_delta: float) -> void:
	progress_bar.value = scene_timer.time_left
	if !player_is_alive and !seal_is_alive:
		return
	
	if Input.is_action_just_pressed("ui_accept") and !is_squinting:
		seal.play("shoot")
		GlobalAudioPlayer._play("res://assets/audio/shot.wav")
		player.play("die")
		player_is_alive = false
	
	if Input.is_action_just_pressed("ui_accept") and is_squinting:
		player.play("shoot")
		GlobalAudioPlayer._play("res://assets/audio/shot.wav")
		seal.play("die")
		seal_is_alive = false


func start_squint():
	var time_before_squint = randf_range(3,4)
	await get_tree().create_timer(time_before_squint).timeout
	seal.play("squint")
	is_squinting = true
	await get_tree().create_timer(squinting_time).timeout
	if seal_is_alive and player_is_alive:
		seal.play("shoot")
		GlobalAudioPlayer._play("res://assets/audio/shot.wav")
		player.play("die")

func _on_scene_ended():
	result.emit(player_is_alive)
