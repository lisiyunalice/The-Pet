# ball.gd
extends Area2D
signal collected

# energy gained when collected
@export var energy_gain: int = 10

func _ready() -> void:
	# 连接 body_entered，玩家进入时触发
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		emit_signal("collected", energy_gain)
		queue_free()
