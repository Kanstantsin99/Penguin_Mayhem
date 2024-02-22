extends Node

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


func _ready() -> void:
	current_scene = load("res://scene/ui/nokia_stratup.tscn").instantiate()
	add_child(current_scene)


func switch_scene(res_path):
	call_deferred("_deferred_switch_scene", res_path)


func _deferred_switch_scene(res_path):
	if current_scene:
		current_scene.free()
	var s = load(res_path)
	current_scene = s.instantiate()
	if current_scene.get_parent():
		current_scene.get_parent().remove_child(current_scene)
	screen_transition.transition()
	await screen_transition.transition_halfway
	if current_scene.has_signal("result"):
		current_scene.result.connect(_on_result)
	add_child(current_scene)


func run_next_game():
	if current_scene.has_signal("result"):
		current_scene.result.disconnect(_on_result)
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
	if result:
		print("You win")
	else:
		print("You loose")
	run_next_game()
