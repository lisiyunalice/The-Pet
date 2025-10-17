extends CollisionShape2D

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("clicked")
		   # var new_scene = load("res://scenes/NextScene.tscn")
			#get_tree().change_scene_to_packed(new_scene)
