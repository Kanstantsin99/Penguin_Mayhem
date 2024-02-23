extends Node

var lives = 4
var current_scene = null
var minigame = {
	CrazyCar = {
		path = "res://scene/mini_games/crazy_car/crazy_car.tscn",
		difficulty = 0
	},
	RunnyNose = {
		path = "res://scene/mini_games/runny_nose/runny_nose.tscn",
		difficulty = 0
	}
}

@onready var screen_transition: CanvasLayer = $ScreenTransition
@onready var level_result: CanvasLayer = $LevelResult


func _ready() -> void:
	current_scene = load("res://scene/ui/nokia_stratup.tscn").instantiate()
	add_child(current_scene)


func switch_scene(res_path):
	call_deferred("_deferred_switch_scene", res_path)


# Empties current_scene and connects result signal
func _deferred_switch_scene(res_path):
	if current_scene.has_signal("result"):
		current_scene.result.disconnect(_on_result)
	if current_scene:
		current_scene.free()
	var s = load(res_path)
	current_scene = s.instantiate()
	if current_scene.get_parent():
		current_scene.get_parent().remove_child(current_scene)
	if current_scene.has_signal("result"):
		current_scene.result.connect(_on_result)
	add_child(current_scene)


# Updates 
func run_next_game():
	var difficulty = minigame[current_scene.name].difficulty
	minigame[current_scene.name].difficulty += 1
	
	for game in minigame:
		if minigame[game].difficulty == difficulty:
			switch_scene(minigame[game].path)
			return
	
	difficulty += 1
	for game in minigame:
		if minigame[game].difficulty == difficulty:
			switch_scene(minigame[game].path)
			return


func _on_result(result):
	screen_transition.transition_in()
	if !result:
		lives -= 1
		if lives == 0:
			get_tree().quit()
	
	await screen_transition.transition_halfway
	level_result.show_result(lives)
	await level_result.showed
	screen_transition.transition_out()
	run_next_game()
