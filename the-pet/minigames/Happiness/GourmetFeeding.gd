extends Node2D

@export var treat_level_1_scene: PackedScene
@export var treat_level_2_scene: PackedScene
@export var treat_level_3_scene: PackedScene
@export var treat_level_4_scene: PackedScene
@export var treat_level_5_scene: PackedScene
@export var treat_level_6_scene: PackedScene
@export var treat_level_7_scene: PackedScene
@export var treat_level_8_scene: PackedScene
@export var treat_level_9_scene: PackedScene
@export var treat_level_10_scene: PackedScene

@export var all_treat_scenes: Array[PackedScene]

@onready var score_label: Label = $ScoreLabel
@onready var final_score_label: Label = $GameOverLayer/CenterContainer/VBoxContainer/ScoreDisplayLabel
@onready var game_over_layer: CanvasLayer = $GameOverLayer
@onready var drop_cooldown_timer: Timer = $DropCooldownTimer
@onready var next_treat_preview: Sprite2D = $NextTreatPreview
@onready var end_game_area: Area2D = $EndGameArea

const DROP_START_Y = -50.0
const BOWL_WIDTH = 400.0
const BOWL_X_START = 376.0
const MAIN_SPRITE_NAME = "MainDessertSprite"
const MAX_INITIAL_LEVEL = 2

var treat_pool: Array[PackedScene] = []
var current_treat_scene: PackedScene
var score: int = 0
var can_drop: bool = true


func _ready():
	add_to_group("merger")
	treat_pool = [treat_level_1_scene, treat_level_2_scene]
	
	randomize_next_treat()
	update_score_ui()


func get_texture_from_scene(scene: PackedScene) -> Texture2D:
	var instance = scene.instantiate()
	var texture: Texture2D = null
	texture = _recursive_find_sprite(instance)
	var sprite_to_preview = instance.find_child(MAIN_SPRITE_NAME, true)
	if sprite_to_preview == null:
		sprite_to_preview = instance.find_child("Sprite2D", true)
	if sprite_to_preview is Sprite2D:
		texture = sprite_to_preview.texture
	instance.queue_free()
	return texture


func randomize_next_treat():
	if not treat_pool.is_empty():
		current_treat_scene = treat_pool.pick_random()
		if current_treat_scene != null and is_instance_valid(next_treat_preview):
			next_treat_preview.texture = get_texture_from_scene(current_treat_scene)


func _recursive_find_sprite(node: Node) -> Texture2D:
	if node is Sprite2D:
		return node.texture
	for child in node.get_children():
		var result = _recursive_find_sprite(child)
		if result != null:
			return result
	return null


func _unhandled_input(event):
	if can_drop and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var click_x = event.position.x
		if click_x >= BOWL_X_START and click_x <= BOWL_X_START + BOWL_WIDTH:
			drop_treat(click_x)
			get_viewport().set_input_as_handled()


func drop_treat(x_position):
	if current_treat_scene == null:
		return
	can_drop = false
	drop_cooldown_timer.start()
	var new_treat = current_treat_scene.instantiate()
	add_child(new_treat)
	new_treat.global_position = Vector2(x_position, DROP_START_Y)
	randomize_next_treat()
	
	
func _on_drop_cooldown_timer_timeout():
	can_drop = true
	
	
func request_merge(treat1: Treat, treat2: Treat):
	if not is_instance_valid(treat1) or not is_instance_valid(treat2):
		return
	var points_to_add = (treat1.level + 1) * 10
	add_score(points_to_add)
	var merge_position = (treat1.global_position + treat2.global_position) / 2
	var next_scene: PackedScene = treat1.next_treat_scene
	treat1.queue_free()
	treat2.queue_free()


	if next_scene != null:
		var new_treat = next_scene.instantiate()
		add_child(new_treat)
		new_treat.global_position = merge_position


func add_score(amount: int):
	score += amount
	update_score_ui()


func update_score_ui():
	if is_instance_valid(score_label):
		score_label.text = "Score: " + str(score)


func _on_end_game_area_body_entered(body: Node2D):
	if body is Treat:
		game_over()


func game_over():
	get_tree().paused = true
	if is_instance_valid(game_over_layer):
		game_over_layer.visible = true
	if is_instance_valid(final_score_label):
		final_score_label.text = "Score: " + str(score)
	print("!!! GAME OVER !!! Score: " + str(score))


func _on_retry_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://minigames/Happiness/Gourmet Feeding.tscn") 
