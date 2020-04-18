extends RigidBody2D

signal hit_by_character

onready var eye1 = $CollisionShape2D/Sprite/Eye
onready var eye2 = $CollisionShape2D/Sprite/Eye2

func _ready():
	eye1.initialize(self)
	eye2.initialize(self)

func _process(delta):
	pass

func _on_Girl_body_entered(body):
	if body is Character:
		emit_signal("hit_by_character")
