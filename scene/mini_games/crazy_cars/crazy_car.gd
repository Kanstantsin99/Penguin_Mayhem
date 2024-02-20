extends Node


signal result(bool)

@onready var player: CharacterBody2D = $Node2D/Player
@onready var scene_timer: Timer = $SceneTimer


func _ready() -> void:
	scene_timer.timeout.connect(_on_scene_ended)


# Sends result(true) if player is_alive
func _on_scene_ended():
	result.emit(player.is_alive)
