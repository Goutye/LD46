extends RigidBody2D
class_name ButtonPush

var _is_pushed := false

signal on_button_pushed

onready var off_sprite : Sprite = $OffSprite
onready var on_sprite : Sprite = $OnSprite
onready var off_collision : CollisionShape2D = $OffCollision
onready var on_collision : CollisionShape2D = $OnCollision


func _ready():
	on_sprite.visible = false
	on_collision.set_deferred("disabled", true)


func get_forward_vector() -> Vector2:
	var angle = get_global_transform().get_rotation()
	return Vector2(cos(angle), sin(angle))

func _push_button():
	off_sprite.visible = false
	off_collision.set_deferred("disabled", true)
	on_sprite.visible = true
	on_collision.set_deferred("disabled", false)
	_is_pushed = true
	
	emit_signal("on_button_pushed")

func on_collide_player(body):
	if not _is_pushed:
		var player_velocity : Vector2 = body.old_velocity
		var button_forward : Vector2 = get_forward_vector()
		
		var dot = button_forward.dot(player_velocity.normalized())

		if dot <= -0.1:
			_push_button()
