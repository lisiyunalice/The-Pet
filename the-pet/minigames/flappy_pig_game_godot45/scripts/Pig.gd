extends CharacterBody2D

const GRAVITY = 900.0
const JUMP_FORCE = -350.0
var velocity = Vector2.ZERO

func _physics_process(delta):
    if Input.is_action_just_pressed("ui_accept"):
        velocity.y = JUMP_FORCE
    velocity.y += GRAVITY * delta
    move_and_slide()
