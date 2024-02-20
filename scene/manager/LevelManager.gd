extends Node

var current_scene = null


func _ready() -> void:
	switch_scene("res://scene/ui/nokia_stratup.tscn")


func switch_scene(res_path):
	call_deferred("_deferred_switch_scene", res_path)


func _deferred_switch_scene(res_path):
	if current_scene:
		current_scene.free()
	var s = load(res_path)
	current_scene = s.instantiate()
	if current_scene.get_parent():
		current_scene.get_parent().remove_child(current_scene)
	add_child(current_scene)
	
