# sheep.gd
extends Area2D
signal reached_goal

@export var energy_gain: int = 50

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		emit_signal("reached_goal", energy_gain)
		set_deferred("monitoring", false)
