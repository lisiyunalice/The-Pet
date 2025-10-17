extends Sprite2D

@export var scroll_speed: float = 100.0  # 控制速度，可自己调节

var start_position: Vector2

func _ready():
	start_position = position

func _process(delta):
	position.x -= scroll_speed * delta
	if position.x <= -texture.get_size().x:
		position.x = start_position.x
