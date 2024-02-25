extends Node

var lives = 4
var current_scene = null
var minigame = {
	EggReborn = {
		path = "res://scene/mini_games/egg_reborn/egg_reborn.tscn",
		difficulty = 1,
		guidance = "Catch"
	},
	Egg = {
		path = "res://scene/mini_games/egg/egg.tscn",
		difficulty = 1,
		guidance = "Move"
	},
	Circle = {
		path = "res://scene/mini_games/circle/circle.tscn",
		difficulty = 1,
		guidance = "Shoot"
	},
	PenguinOfSnowshima = {
		path = "res://scene/mini_games/penguin_of_snowshima/penguin_of_snowshima.tscn",
		difficulty = 1,
		guidance = "Press"
	},
	CowboyDraw = {
		path = "res://scene/mini_games/cowboy_draw/cowboy_draw.tscn",
		difficulty = 1,
		guidance = "Shoot"
	},
	CrazyCar = {
		path = "res://scene/mini_games/crazy_car/crazy_car.tscn",
		difficulty = 1,
		guidance = "Jump"
	},
	RunnyNose = {
		path = "res://scene/mini_games/runny_nose/runny_nose.tscn",
		difficulty = 1,
		guidance = "Rub"
	}
}

@onready var screen_transition: CanvasLayer = $ScreenTransition
@onready var level_result: CanvasLayer = $LevelResult
@onready var screen_guidance: CanvasLayer = $ScreenGuidance


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
	if "difficulty" in current_scene:
		current_scene.difficulty = minigame[current_scene.name].difficulty
	if current_scene.has_signal("result"):
		current_scene.result.connect(_on_result)
	
	add_child(current_scene)


# Select game from minigame and updates its difficulty in dict
func run_next_game():
	var difficulty = 0
	if !current_scene.name == "MainMenu":
		difficulty = minigame[current_scene.name].difficulty
		minigame[current_scene.name].difficulty += 1
	
	for game in minigame:
		if minigame[game].difficulty == difficulty:
			switch_scene(minigame[game].path)
			screen_guidance.show_guidance(minigame[game].guidance)
			return
	
	difficulty += 1
	for game in minigame:
		if minigame[game].difficulty == difficulty:
			switch_scene(minigame[game].path)
			screen_guidance.show_guidance(minigame[game].guidance)
			return


# Shows LevelResult with transitions
# checks if lives > 0
# removes child from a LevelManager
func _on_result(result):
	screen_transition.transition_in()
	if result:
		GlobalAudioPlayer._play("res://assets/audio/jingle1.wav")
	if !result:
		GlobalAudioPlayer._play("res://assets/audio/negative1.wav")
		lives -= 1
		if lives == 0:
			# NOTE: Here transition to end screen is needed
			await screen_transition.transition_halfway
			level_result.show_result(lives)
			await level_result.showed
			get_tree().quit()
	
	if current_scene.get_parent():
		current_scene.get_parent().remove_child(current_scene)
	
	await screen_transition.transition_halfway
	level_result.show_result(lives)
	await level_result.showed
	screen_transition.transition_out()
	run_next_game()
