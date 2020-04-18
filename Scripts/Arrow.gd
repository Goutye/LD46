extends Node2D


var _player : Character
var _start_arrow : Sprite
var _middle_arrow : Sprite
var _end_arrow : Sprite

func _ready():
	_start_arrow = $start
	_middle_arrow = $start/middle
	_end_arrow = $start/end
	_player = get_parent()


func _process(delta):
	if _player.is_dragging:
		visible = true
		var impulse_vector : Vector2 = _player.get_current_dragging_impulse_vector()
		var length = impulse_vector.length()
		var angle = impulse_vector.angle()

		_start_arrow.global_rotation = angle
		_middle_arrow.scale = Vector2(length, 1)
		_end_arrow.position = Vector2(length, 0)
	else:
		visible = false
