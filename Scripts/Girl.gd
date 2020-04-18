extends RigidBody2D
class_name Girl

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
		
		eye1.set_target(body.position)
		eye2.set_target(body.position)
		body.on_collision_with_girl(self)
		
		$CollisionShape2D/ParticleHeart.emitting = true
		$CollisionShape2D/ParticleHeart2.emitting = true
