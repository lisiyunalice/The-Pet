# maze.gd
extends Node2D

@onready var energy_bar: ProgressBar = $EnergyBar
@onready var energy_label: Label = $EnergyLabel
@onready var ball_container: Node = $Ball  
@onready var sheep_area: Node = $Sheep
@onready var exit_button: Button = $ExitButton
@onready var player: Node = $Player

var energy: int = 0
const ENERGY_MAX: int = 100

func _ready() -> void:
	# 初始化 UI
	energy = 0
	_update_energy_display()

	# 连接 Exit 按钮
	if exit_button:
		exit_button.pressed.connect(_on_exit_pressed)

	# 连接现有 Ball 容器里的 child（如果你已经放了 ball1, ball2...）
	if ball_container:
		for child in ball_container.get_children():
			# 如果 child 挂了 ball.gd（有 signal "collected"）
			if child.has_signal("collected"):
				child.collected.connect(_on_ball_collected)
			# 如果 child 是 Area2D 且没有上述 signal，连接 body_entered 作后备
			elif child is Area2D:
				child.body_entered.connect(_on_ball_body_entered)

	# 如果没有现成的 balls，尝试从 Ball.tscn 生成（非强制）
	if ball_container and ball_container.get_child_count() == 0:
		if FileAccess.file_exists("res://minigames/maze/Ball.tscn"):
			var ball_scene := load("res://minigames/maze/Ball.tscn")
			for i in range(8):
				var inst = ball_scene.instantiate()
				inst.position = Vector2(100 + randi() % 700, 100 + randi() % 400)
				ball_container.add_child(inst)
				if inst.has_signal("collected"):
					inst.collected.connect(_on_ball_collected)
				elif inst is Area2D:
					inst.body_entered.connect(_on_ball_body_entered)

	# 连接 sheep 的信号（如果 sheep.gd 定义了 reached_goal）
	if sheep_area:
		if sheep_area.has_signal("reached_goal"):
			sheep_area.reached_goal.connect(_on_sheep_reached)
		elif sheep_area is Area2D:
			sheep_area.body_entered.connect(_on_sheep_body_entered)

func _on_ball_collected(amount: int) -> void:
	_add_energy(amount)

func _on_ball_body_entered(body: Node) -> void:
	# 被连到没有自定义 signal 的 Area2D 会走这里（后备方案）
	if body.name == "Player":
		_add_energy(10)
		# 触发者自己销毁（如果它没有自动处理）
		var sender := get_tree().get_current_scene().get_node(get_tree().get_last_created_node_owner()) if false else null
		# （上面查sender的方法并不稳定，通常在 ball.gd 里做 queue_free()）
		# 不做额外 queue_free，这通常由 ball.gd 自己处理

func _on_sheep_reached(amount: int) -> void:
	_add_energy(amount)
	_on_maze_completed()

func _on_sheep_body_entered(body: Node) -> void:
	if body.name == "Player":
		_add_energy(50)
		_on_maze_completed()

func _add_energy(amount: int) -> void:
	energy = clamp(energy + amount, 0, ENERGY_MAX)
	_update_energy_display()

func _update_energy_display() -> void:
	if energy_bar:
		energy_bar.max_value = ENERGY_MAX
		energy_bar.value = energy
	if energy_label:
		energy_label.text = "Energy: %d" % energy

func _on_exit_pressed() -> void:
	print("Exit pressed — 返回主界面（占位）")
	# TODO: 改成真正的场景切换，例如：
	# get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_maze_completed() -> void:
	print("Maze completed. Energy:", energy)
	# 可做：播放提示、延时返回主界面等
