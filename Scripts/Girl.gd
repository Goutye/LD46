extends RigidBody2D
class_name Girl

signal hit_by_character
signal has_died

onready var eye1 = $CollisionShape2D/Sprite/Eye
onready var eye2 = $CollisionShape2D/Sprite/Eye2

var _is_dead = false

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
		
		$CollisionShape2D/Sprite/ParticleHeart.emitting = true
		$CollisionShape2D/Sprite/ParticleHeart2.emitting = true

func on_hit_by_lava():
	if not _is_dead:
		_is_dead = true
		emit_signal("has_died")
		flux.to($CollisionShape2D/Sprite, 0.8, {scale_x = 0.01}, "absolute").ease("bounce","in")
		flux.to($CollisionShape2D/Sprite, 0.8, {scale_y = 0.01}, "absolute").ease("bounce","in")
		flux.to($CollisionShape2D/Sprite/ParticleHeart, 0.8, {modulate_a = 0}, "absolute").ease("quad", "out")
		flux.to($CollisionShape2D/Sprite/ParticleHeart2, 0.8, {modulate_a = 0}, "absolute").ease("quad", "out")

