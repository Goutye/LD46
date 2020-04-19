extends Sprite

export var scale_max = 75.0
export var duration_start = 0.8
export var duration_end = 2.5

signal anim_end

func _ready():
	scale = Vector2(0.01, 0.01)
	visible = false
	
func play_end_level_transition():
	if not visible:
		visible = true
		scale = Vector2(0.01, 0.01)
		flux.to(self, duration_end, {scale_x = scale_max}, "absolute").ease("bounce","in")
		flux.to(self, duration_end, {scale_y = scale_max}, "absolute").ease("bounce","in").oncomplete.append(funcref(self, "on_anim_end_end"))
	
func play_start_level_transition():
	flux.to(self, duration_start, {scale_x = 0.01}, "absolute").ease("quad","out")
	flux.to(self, duration_start, {scale_y = 0.01}, "absolute").ease("quad","out").oncomplete.append(funcref(self, "on_anim_start_end"))
	
func on_anim_end_end():
	emit_signal("anim_end")

func on_anim_start_end():
	visible = false
