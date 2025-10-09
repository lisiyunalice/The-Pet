extends Node2D

@onready var energy_bar = $EnergyBar
@onready var energy_label = $EnergyLabel
@onready var balls = $Balls
@onready var sheep = $Sheep

var energy := 0

func _ready():
	# 初始化
	_spawn_balls()
	sheep.position = Vector2(900, 500)
	sheep.reached_goal.connect(_on_sheep_reached)
	$ExitButton.pressed.connect(_on_exit_pressed)

func _spawn_balls():
	var ball_scene = preload("res://minigames/maze/Ball.tscn")
	for i in range(10):
		var ball = ball_scene.instantiate()
		ball.position = Vector2(randi() % 900 + 50, randi() % 500 + 50)
		balls.add_child(ball)
		ball.collected.connect(_on_ball_collected)

func _on_ball_collected():
	energy += 10
	_update_energy_display()

func _on_sheep_reached():
	energy += 50
	_update_energy_display()
	print("You found the sheep! +50 energy")

func _on_exit_pressed():
	print("Exit Game")  # 未来可改成 get_tree().change_scene_to_file("res://MainMenu.tscn")

func _update_energy_display():
	energy_bar.value = energy
	energy_label.text = "Energy: " + str(energy)
