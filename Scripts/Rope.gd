extends StaticBody2D

export var rope_time = 10
var current_rope_time = 0
var _is_broken = false

var _origin_scale_x : float
var _origin_modulate : Color

export var min_scale = 0.5
export var min_modulate = Color(0.75, 0.25, 0.25, 1)

onready var sprites = [$CollisionShape2D/PinJoint2D/ChainPiece/CollisionShape2D/PinJoint2D/Sprite, \
$CollisionShape2D/PinJoint2D/ChainPiece/CollisionShape2D/PinJoint2D/ChainPiece2/CollisionShape2D/PinJoint2D/Sprite, \
$CollisionShape2D/PinJoint2D/ChainPiece/CollisionShape2D/PinJoint2D/ChainPiece2/CollisionShape2D/PinJoint2D/ChainPiece3/CollisionShape2D/PinJoint2D/Sprite]


func _ready():
	_origin_scale_x = sprites[0].scale.x
	_origin_modulate = sprites[0].modulate
	

func _process(delta):
	if not _is_broken:
		current_rope_time += delta

		var ratio = current_rope_time / rope_time
		var quad_ratio = ratio*ratio
		var modulate = lerp(_origin_modulate, min_modulate, ratio)
		var scale_x = lerp(_origin_scale_x, min_scale, quad_ratio)

		for i in range(sprites.size()):
			var sprite = sprites[i]
			var ratio_pos = float(i + 1) / (sprites.size())

			sprite.modulate = lerp(_origin_modulate, modulate, ratio_pos)
			sprite.scale.x = lerp(_origin_scale_x, scale_x, ratio_pos)

		if current_rope_time >= rope_time:
			detach()

func detach():
	$AudioStreamPlayer2D.play()
	var joint = $CollisionShape2D/PinJoint2D/ChainPiece/CollisionShape2D/PinJoint2D/ChainPiece2/CollisionShape2D/PinJoint2D/ChainPiece3/CollisionShape2D/PinJoint2D
	joint.node_b = NodePath("")

	_is_broken = true

func get_time_ratio():
	return current_rope_time / rope_time
