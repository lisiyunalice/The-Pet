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


const DROP_START_Y = -50.0 
const BOWL_WIDTH = 400.0   
const BOWL_X_START = 376.0
var treat_pool: Array[PackedScene] = []
var current_treat_scene: PackedScene 


func _ready():
	add_to_group("merger")
	treat_pool = [treat_level_1_scene, treat_level_2_scene]
	randomize_next_treat()


func randomize_next_treat():
	if not treat_pool.is_empty():
		current_treat_scene = treat_pool.pick_random()
func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var click_x = event.position.x
		if click_x >= BOWL_X_START and click_x <= BOWL_X_START + BOWL_WIDTH:
			drop_treat(click_x)
			get_viewport().set_input_as_handled()
func drop_treat(x_position):
	if current_treat_scene == null:
		return
	var new_treat = current_treat_scene.instantiate()
	add_child(new_treat)
	new_treat.global_position = Vector2(x_position, DROP_START_Y)
	randomize_next_treat()


func request_merge(treat1: Treat, treat2: Treat):
	if not is_instance_valid(treat1) or not is_instance_valid(treat2):
		return
	var merge_position = (treat1.global_position + treat2.global_position) / 2
	var next_scene: PackedScene = treat1.next_treat_scene
	var new_treat = next_scene.instantiate()
	add_child(new_treat)
	new_treat.global_position = merge_position
	treat1.queue_free()
	treat2.queue_free()
