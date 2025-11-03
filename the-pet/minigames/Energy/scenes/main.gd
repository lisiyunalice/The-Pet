extends Node

@export var pipe_scene : PackedScene

var game_running : bool
var game_over : bool
var scroll
var score
const SCROLL_SPEED : int = 4
var screen_size : Vector2i
var ground_height : int
var pipes : Array
const PIPE_DELAY : int = 100
const PIPE_RANGE : int = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	
	# 给退出按钮绑定信号（假设按钮路径是 $ExitButton）
	if $ExitButton:
		$ExitButton.pressed.connect(func(): _on_exit_pressed())
		
	new_game()
	
func _on_exit_pressed():
	get_tree().change_scene_to_file("res://main scene.tscn")

func new_game():
	#reset variables
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	$ScoreLabel.text = "Energy: " + str(score)
	$GameOver.hide()
	$ResultLabel.hide()  # 新增：隐藏结果提示（成功/失败）
	get_tree().call_group("pipes", "queue_free")
	pipes.clear()
	#generate starting pipes
	generate_pipes()
	$Pet.reset()
	
func _input(event):
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				else:
					if $Pet.flying:
						$Pet.flap()
						check_top()

func start_game():
	game_running = true
	$Pet.flying = true
	$Pet.flap()
	#start pipe timer
	$PipeTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if game_running:
		scroll += SCROLL_SPEED
		#reset scroll
		if scroll >= screen_size.x:
			scroll = 0
		#move ground node
		$Ground.position.x = -scroll
		#move pipes
		for pipe in pipes:
			pipe.position.x -= SCROLL_SPEED


func _on_pipe_timer_timeout():
	generate_pipes()
	
func generate_pipes():
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x + PIPE_DELAY
	pipe.position.y = (screen_size.y - ground_height) / 2.0  + randi_range(-PIPE_RANGE, PIPE_RANGE)
	pipe.hit.connect(bird_hit)
	pipe.scored.connect(scored)
	add_child(pipe)
	pipes.append(pipe)
	
func scored():
	score += 10
	$ScoreLabel.text = "Energy: " + str(score)

func check_top():
	if $Pet.position.y < 0:
		$Pet.falling = true
		stop_game()

func stop_game():
	$PipeTimer.stop()
	$GameOver.show()
	$Pet.flying = false
	game_running = false
	game_over = true
	
	#胜负判定
	if score >= 100:
		$ResultLabel.text = "Success! Energy Full🌟"
	else:
		$ResultLabel.text = "Failed 💔 Still Tired..."
	$ResultLabel.show()
	
func bird_hit():
	$Pet.falling = true
	stop_game()

func _on_ground_hit():
	$Pet.falling = false
	stop_game()

func _on_game_over_restart():
	new_game()
