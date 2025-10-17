extends Area2D

signal passed

@onready var top_pipe = $TopPipe
@onready var bottom_pipe = $BottomPipe

var speed = 200

func _process(delta):
	position.x -= speed * delta

	# 超出屏幕后销毁
	if position.x < -100:
		queue_free()

# 当猪飞过管道时发射信号
func _on_body_exited(body):
	if body.name == "Pig":
		emit_signal("passed")
