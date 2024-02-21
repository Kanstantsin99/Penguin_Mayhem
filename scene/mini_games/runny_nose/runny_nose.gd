extends Node

signal result(bool)

@export var hand_speed = 80
@export var drop_speed = 5

var is_on_nose: bool = false
var nose_is_alive: bool = true

@onready var ice: Sprite2D = $Node2D/Ice
@onready var drop: Sprite2D = $Node2D/Drop
@onready var drop_hit_box: Area2D = $Node2D/Drop/DropHitBox
@onready var hand: Sprite2D = $Node2D/Hand
@onready var scene_timer: Timer = $SceneTimer
@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar
@onready var nose_collision: Area2D = $Node2D/Nose/NoseCollision


func _ready() -> void:
	drop_hit_box.area_entered.connect(_on_hand_entered)
	drop_hit_box.area_exited.connect(_on_hand_exited)
	nose_collision.area_exited.connect(_on_drop_exited)
	scene_timer.timeout.connect(_on_scene_ended)


func _process(delta: float) -> void:
	var hand_dir = get_direction()
	hand.translate(hand_speed * hand_dir * delta)
	hand.global_position = hand.global_position.clamp(Vector2.ZERO, Vector2(84, 48))
	
	var drop_dir: Vector2 = Vector2.DOWN
	if is_on_nose and hand_dir != Vector2.ZERO:
		drop_dir = Vector2.UP
	drop.translate(drop_speed * drop_dir * delta)
	
	progress_bar.value = scene_timer.time_left


func get_direction() -> Vector2:
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	return Vector2(direction_x, direction_y).normalized()


func _on_hand_entered(_area):
	is_on_nose = true
	print("I'm here")


func _on_hand_exited(_area):
	is_on_nose = false
	print("I'm out of here")


func _on_drop_exited(_area):
	drop_speed = drop_speed * 20
	drop_hit_box.free()
	ice.visible = true
	nose_is_alive = false



func _on_scene_ended():
	result.emit(nose_is_alive)
