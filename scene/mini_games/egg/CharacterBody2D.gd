extends CharacterBody2D

const SPEED = 85

@onready var penguin = $Penguin
@onready var area_2d = $Area2D
@onready var main = $".."

func _ready():
	penguin.play("idle")
	area_2d.body_entered.connect(_body_entered)

func _body_entered(node):
	node.free()
	main._catch()

func _process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if direction < 0:
			penguin.flip_h = true
		if direction > 0:
			penguin.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
