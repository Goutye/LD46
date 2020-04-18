extends RigidBody2D


func _ready():
	pass

func _process(delta):
	pass

func _on_Girl_body_entered(body):
	if body is Character:
		print("GG")
