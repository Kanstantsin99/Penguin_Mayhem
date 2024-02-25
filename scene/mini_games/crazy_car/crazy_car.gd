extends Node


signal result(bool)

var difficulty = 1

@onready var player: CharacterBody2D = $Node2D/Player
@onready var scene_timer: Timer = $SceneTimer
@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar
@onready var seal: CharacterBody2D = $Node2D/Seal


func _ready() -> void:
	scene_timer.timeout.connect(_on_scene_ended)
	seal.speed = seal.speed * difficulty / 1.5


func _process(_delta: float) -> void:
	progress_bar.value = scene_timer.time_left

# Sends result(true) if player is_alive
func _on_scene_ended():
	result.emit(player.is_alive)
