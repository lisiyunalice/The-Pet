extends RigidBody2D
class_name Treat


@export var level: int = 1 
@export var next_treat_scene: PackedScene


var merged: bool = false 


func _ready():
	contact_monitor = true
	max_contacts_reported = 1 
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D):
	if body is Treat and not merged and not body.merged:
		var other_treat = body as Treat
		if other_treat.level == self.level:
			merged = true
			other_treat.merged = true
			get_tree().call_group("merger", "request_merge", self, other_treat)
