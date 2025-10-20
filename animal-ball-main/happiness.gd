extends HBoxContainer
@export var icon : Texture2D
@export var minigame: PackedScene
var PetAlive = true

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("clicked!")
		 #   var new_scene = load("res://scenes/NextScene.tscn")
		  #  get_tree().change_scene_to_packed(new_scene)
		
var A: int = 50  # 假设初始值为 50
var max_A: int = 100        # 最大值，用来设置进度条上限
var timer: Timer
@onready var progress_bar = $ProgressBar  # 获取场景中的 ProgressBar 节点

func _ready():
	 # 初始化进度条
	$TextureButton.texture_normal = icon
	
	# 创建计时器
	timer = Timer.new()
	timer.wait_time = 0.1  # 每 n 秒触发一次
	timer.one_shot = false  # 不只执行一次，循环触发
	timer.autostart = true  # 自动启动
	add_child(timer)
	
	# 连接计时器信号
	timer.connect("timeout", self._on_timer_timeout)

func _on_timer_timeout():
	if A > 0:
		A -= 1
		progress_bar.value = A
		print("A 变量减少，当前值为: ", A)
	else:
		print("A 已经降到 0，不再减少。", "Your pet is dead.")
		timer.stop()
		PetAlive = false
		
func _process(delta: float) -> void:
	if not PetAlive :
		A += 1
		print("Processing, PetAlive:", PetAlive)
		$ProgressBar.value = A
		if A > 80:
			PetAlive = true
			print("Your pet has rivived.")
			$timer.start() #Not sure why the countdown would not restart
	

func _on_texture_button_button_down() -> void:
	print("Hi")
	# get_tree().change_scene_to_file("res://LoremIpsum.tscn")
	get_tree().change_scene_to_packed(minigame)
	pass # Replace with function body.
