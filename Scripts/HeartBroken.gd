extends Node2D

signal end_level_anim_end
signal start_level_anim_end

export var scale_begin = 25.0
export var duration_normal = 1.5
export var duration_broken = 1.5

var _offset

func _ready():
	$HeartParts.visible = false
	_offset = $HeartParts/HeartRight.position.x
	
func play_end_level_transition():
	$HeartParts.visible = true
	$HeartParts/HeartLeft.position.x = -_offset
	$HeartParts/HeartRight.position.x = _offset
	$HeartParts/HeartLeft.modulate.a = 1
	$HeartParts/HeartRight.modulate.a = 1
	$HeartParts.scale = Vector2(0.01, 0.01)
	
	flux.to($HeartParts, duration_normal, {scale_x = scale_begin}, "absolute").ease("back","out")
	flux.to($HeartParts, duration_normal, {scale_y = scale_begin}, "absolute").ease("back","out").oncomplete.append(funcref(self, "on_end_anim_end"))

func play_start_level_transition():
	flux.to($HeartParts/HeartLeft, duration_broken, {x2D = -10}, "relative").ease("quad", "out")
	flux.to($HeartParts/HeartRight, duration_broken, {x2D = 10}, "relative").ease("quad", "out")
	flux.to($HeartParts/HeartLeft, duration_broken, {modulate_a = 0}, "absolute").ease("quad", "in")
	flux.to($HeartParts/HeartRight, duration_broken, {modulate_a = 0}, "absolute").ease("quad", "in").oncomplete.append(funcref(self, "on_start_anim_end"))

func on_start_anim_end():
	$HeartParts.visible = false
	emit_signal("start_level_anim_end")

func on_end_anim_end():
	emit_signal("end_level_anim_end")
