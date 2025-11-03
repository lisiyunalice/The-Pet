extends HBoxContainer
@export var icon : Texture2D
@export var minigame: PackedScene
var PetAlive = true
@onready var mini_game_container = $MiniGameContainer


#func _input_event(viewport, event, shape_idx):
#	if event is InputEventMouseButton and event.pressed:
#		if event.button_index == MOUSE_BUTTON_LEFT:
#			print("clicked!")
		 #   var new_scene = load("res://scenes/NextScene.tscn")
		  #  get_tree().change_scene_to_packed(new_scene)
		
#var A: int = 50  # 假设初始值为 50
var max_A: int = 100        # 最大值，用来设置进度条上限
var timer: Timer
@onready var progress_bar = $ProgressBar  # 获取场景中的 ProgressBar 节点

func _ready():
	update_bars()
	 # 初始化进度条
	$TextureButton.texture_normal = icon
	
#	var now = Time.get_unix_time_from_system()
#	Global.remaining_time -= A
#	Global.last_timestamp = now
#	A = now - Global.last_timestamp
	
	# 创建计时器
	timer = Timer.new()
	timer.wait_time = 10  # 每 n 秒触发一次
	timer.one_shot = false  # 不只执行一次，循环触发
	timer.autostart = true  # 自动启动
	add_child(timer)
	
	# 连接计时器信号
	timer.connect("timeout", self._on_timer_timeout)
	
	Global.connect("stats_changed", Callable(self, "update_bars"))

func update_bars():
	var stats = Global.player_stats
	progress_bar.value = stats["food"] #需要替换
	
func _on_timer_timeout():
	if Global.player_stats["food"] > 0:
		Global.player_stats["food"] -= 1
		progress_bar.value = Global.player_stats["food"]
		Global.emit_signal("stats_changed")
		print("Food 变量减少，当前值为: ", Global.player_stats["food"])
	else:
		print("Food 已经降到 0，不再减少。", "Your pet is dead.")
		timer.stop()
		PetAlive = false
		
func _process(delta: float) -> void:
	if not PetAlive :
		Global.player_stats["food"] += 0.1
		print("Processing, PetAlive:", PetAlive)
		$ProgressBar.value = Global.player_stats["food"]
		if Global.player_stats["food"] > 80:
			PetAlive = true
			print("Your pet has rivived.")
			timer.start()

func _on_texture_button_button_down() -> void:
	print("Switched to mini game.")
	load_mini_game("res://minigames/hunger/HungerMiniGame.tscn") #需要替换为对应游戏
	
func load_mini_game(path: String) -> void:
	var scene = load(path)
	var mini_game = scene.instantiate()
	mini_game_container.add_child(mini_game)

	# 连接迷你游戏的信号（假设迷你游戏中定义了 signal game_finished）
	mini_game.connect("game_finished", Callable(self, "_on_mini_game_finished"))
	
# ✅ 迷你游戏结束后移除它
func _on_mini_game_finished() -> void:
	if mini_game_container.get_child_count() > 0:
		mini_game_container.get_child(0).queue_free()
		print("Mini game closed.")
	
	# get_tree().change_scene_to_file("res://LoremIpsum.tscn")
#	get_tree().change_scene_to_packed(minigame)
#	pass # Replace with function body.
	
# detect if the mini games were finished successfully then add 35 for the value
