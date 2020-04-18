extends RigidBody2D

signal hit_by_character

func _ready():
	pass

func _process(delta):
	pass

func _on_Girl_body_entered(body):
	if body is Character:
		emit_signal("hit_by_character")
