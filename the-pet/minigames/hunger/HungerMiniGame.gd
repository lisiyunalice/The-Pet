extends Node

@onready var timer = $CountdownTimer
@onready var label = $TimeLabel
@onready var bar = $HungerBar
@onready var start_button = $StartButton

var hunger = 0
var game_active = false  # 控制是否能按空格

func _ready():
	label.text = "Press Start to Begin"
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
			label.text = "Time's up!"
			game_active = false
			start_button.disabled = false

func _input(event):
	# 当倒计时进行中，按空格键则饥饿值 +1
	if game_active and event.is_action_pressed("ui_accept") and timer.time_left > 0:
		hunger += 1
		hunger = clamp(hunger, 0, bar.max_value)
		bar.value = hunger

func _on_CountdownTimer_timeout():
	# 倒计时结束
	game_active = false
	label.text = "Time's up!"
	start_button.disabled = false



func _on_start_button_pressed() -> void:
	pass # Replace with function body.
	hunger = 0
	bar.value = 0
	label.text = "5"
	start_button.disabled = true
	game_active = true
	timer.start()


func _on_countdown_timer_timeout() -> void:
	pass # Replace with function body.
	game_active = false
	label.text = "Time's up!"
	start_button.disabled = false


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://mainscene1102.tscn")
	pass # Replace with function body.
