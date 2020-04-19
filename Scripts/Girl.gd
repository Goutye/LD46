extends RigidBody2D
class_name Girl

signal hit_by_character
signal has_died

onready var eye1 = $CollisionShape2D/Sprite/Eye
onready var eye2 = $CollisionShape2D/Sprite/Eye2

onready var global = get_node("/root/global")

var _is_dead = false
var _has_been_hit_by_character = false

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
		
		if not _has_been_hit_by_character:
			var random = randi() % $AudioKiss.get_child_count()
			$AudioKiss.get_child(random).play()
		
		_has_been_hit_by_character = true

func on_hit_by_lava():
	if not _is_dead:
		global.girl_nb_killed += 1

		for audio in $AudioKiss.get_children():
			audio.stop()
		
		_is_dead = true
		emit_signal("has_died")
		flux.to($CollisionShape2D/Sprite, 0.8, {scale_x = 0.01}, "absolute").ease("bounce","in")
		flux.to($CollisionShape2D/Sprite, 0.8, {scale_y = 0.01}, "absolute").ease("bounce","in")
		flux.to($CollisionShape2D/Sprite/ParticleHeart, 0.8, {modulate_a = 0}, "absolute").ease("quad", "out")
		flux.to($CollisionShape2D/Sprite/ParticleHeart2, 0.8, {modulate_a = 0}, "absolute").ease("quad", "out")

