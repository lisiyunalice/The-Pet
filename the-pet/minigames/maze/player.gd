# player.gd
extends CharacterBody2D

@export var speed: int = 200

func _physics_process(delta: float) -> void:
	var dir := Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		dir.x += 1
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1
	if Input.is_action_pressed("ui_down"):
		dir.y += 1
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1

	if dir != Vector2.ZERO:
		velocity = dir.normalized() * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()
