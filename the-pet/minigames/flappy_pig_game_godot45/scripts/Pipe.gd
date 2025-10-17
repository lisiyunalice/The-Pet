extends Area2D

signal hit

func _ready():
    connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
    if body.name == "Pig":
        emit_signal("hit")
