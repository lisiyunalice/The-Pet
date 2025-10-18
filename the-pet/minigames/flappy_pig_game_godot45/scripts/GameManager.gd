extends Node2D

@onready var pig = $Pig
@onready var energy_bar = $EnergyBar
@onready var game_over_label = $GameOverLabel
@onready var pipe_timer = Timer.new()

var pipe_scene: PackedScene
var energy: float = 50.0
var is_game_over = false

func _ready():
	randomize()
	pipe_scene = preload("res://scenes/Pipe.tscn")

	add_child(pipe_timer)
	pipe_timer.wait_time = 2.0  # 每 2 秒生成一根柱子
	pipe_timer.timeout.connect(spawn_pipe)
	pipe_timer.start()

	pig.died.connect(_on_pig_died)
	update_energy_bar()

func _process(delta):
	if is_game_over:
		return
	energy -= 5 * delta
	if energy < 0:
		energy = 0
	update_energy_bar()

	if Input.is_action_just_pressed("restart") and is_game_over:
		get_tree().reload_current_scene()

	if Input.is_action_just_pressed("restart") and is_game_over:
		get_tree().reload_current_scene()
	if is_game_over: return
	
	energy -= 5 * delta
	if energy < 0:
		energy = 0
	update_energy_bar()

	if Input.is_action_just_pressed("restart") and is_game_over:
		get_tree().reload_current_scene()

func spawn_pipe():
	# var pipe_scene = preload("res://Pipe.tscn")
	
	var gap_y = randf_range(200, 400)
	var gap_size = 150.0

	var top_pipe = pipe_scene.instantiate()
	var bottom_pipe = pipe_scene.instantiate()

	top_pipe.position = Vector2(600, gap_y - gap_size / 2.0 - 200)
	bottom_pipe.position = Vector2(600, gap_y + gap_size / 2.0 + 200)

	add_child(top_pipe)
	add_child(bottom_pipe)


func _on_pig_died():
	is_game_over = true
	game_over_label.visible = true
	pipe_timer.stop()

func _on_pipe_passed():
	if is_game_over: return
	energy += 10.0
	if energy > 100: energy = 100
	update_energy_bar()

func update_energy_bar():
	energy_bar.value = energy
	if energy < 20:
		energy_bar.tint_progress = Color.RED
	elif energy < 80:
		energy_bar.tint_progress = Color.YELLOW
	else:
		energy_bar.tint_progress = Color.GREEN


func _on_pipe_timer_timeout():
	spawn_pipe()

func _on_score_area_body_entered(body):
	if body.name == "Pig":
		@warning_ignore("shadowed_variable")
		var energy_bar = get_node("/root/scenes/energy_bar")
		energy_bar.value = min(energy_bar.value + 10, 100)
