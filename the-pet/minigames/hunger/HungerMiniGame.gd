extends Node

@onready var timer = $CountdownTimer
@onready var label = $TimeLabel
@onready var bar = $HungerBar
@onready var start_button = $StartButton

var hunger = 0
var game_active = false  # 控制是否能按空格

func _ready():
	label.text = "Press Start to Begin. Keep hitting SPACE key to feed your chicken!"
	bar.value = 0

func _on_StartButton_pressed():
	# 每次开始重置
	hunger = 0
	bar.value = 0
	label.text = "5"
	start_button.disabled = true
	game_active = true
	timer.start()

func _process(delta):
	# 每帧更新倒计时文字
	if game_active:
		if timer.time_left > 0:
			label.text = str(int(ceil(timer.time_left)))
		else:
			label.text = "Time's up! All Chicken Dead! Try to be faster next time."
			#game_active = false
			#start_button.disabled = false
			
	if Input.is_action_just_pressed("space"):
		score += 1



func _on_CountdownTimer_timeout():
	# 倒计时结束
	#game_active = false
	label.text = "Time's up! All Chicken Dead! Try to be faster next time."
	#start_button.disabled = false
	#emit_signal("game_finished")



func _on_start_button_pressed() -> void:
	pass # Replace with function body.
	hunger = 0
	bar.value = 0
	label.text = "5"
	start_button.disabled = true
	game_active = true
	timer.start()


func _on_countdown_timer_timeout() -> void:
	gametimes += 1
	if gametimes == 1:
		$chicken1.queue_free()
		timer.start()
		label.text = "1"
		score=0
	elif gametimes == 2:
		$chicken2.queue_free()
		timer.start()
		label.text = "2"
		score=0
		
	elif gametimes == 3:
		$chicken3.queue_free()
		timer.start()
		label.text = "3"
		score=0
	elif gametimes == 4:
		$chicken4.queue_free()
		
		$CanvasLayer.show()
		label.text = "4"
		score=0
		#game_active = false
		label.text = "Time's up!"
		start_button.disabled = false

func updata():
	if gametimes == 1:
		
		label.text = "1"
		score=0
		timer.start()
	elif gametimes == 2:
		
		label.text = "2"
		score=0
		timer.start()
	elif gametimes == 3:
		
		label.text = "3"
		score=0
		timer.start()
	elif gametimes == 4:
		
		label.text = "4"
		score=0
		
		game_active = false
		
		start_button.disabled = false


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main scene.tscn")
	pass # Replace with function body.



func _on_texture_button_pressed() -> void:
	pass # Replace with 	get_tree().change_scene_to_file("res://mainscene1102.tscn")function body.


var score = 0:
	set(v):
		score = v
		if not is_node_ready():
			await ready
		%HungerBar.value = v
		if score == target:
			score = 0
			gametimes += 1
			updata()
			
			
var target = 10
var gametimes = 0


func _on_timer_timeout() -> void:
	pass # Replace with function body.

signal game_finished
func _on_game_won():
	Global.add_reward(0, 0, 35)
	emit_signal("game_finished")  # 通知主场景移除自己
