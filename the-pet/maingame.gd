extends Node2D


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://minigames/hunger/HungerMiniGame.tscn")
	pass # Replace with function body.

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://minigames/Happiness/Gourmet Feeding.tscn")
	pass # Replace with function body.
