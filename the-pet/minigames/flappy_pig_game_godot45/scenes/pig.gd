extends CharacterBody2D

signal died

@export var gravity: float = 900.0
@export var jump_force: float = -400.0
var velocity_y = 0.0
var is_alive = true

func _physics_process(delta):
	if not is_alive:
		return

	velocity_y += gravity * delta
	if Input.is_action_just_pressed("jump"):
		velocity_y = jump_force

	position.y += velocity_y * delta

	if position.y > 600 or position.y < 0:
		die()

func _on_body_entered(body):
	if body.is_in_group("pipe"):
		die()

func die():
	if not is_alive:
		return
	is_alive = false
	died.emit()
