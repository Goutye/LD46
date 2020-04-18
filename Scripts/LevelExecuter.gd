extends Node2D
class_name LevelExecuter

signal on_level_end

var _is_level_ended := false
export var camera_zoom = Vector2(1, 1)


func _ready():
	$Characters/Girl.connect("hit_by_character", self, "_on_girl_hit_by_character")

func _process(delta):
	pass
	
func _on_girl_hit_by_character():
	if not _is_level_ended:
		_is_level_ended = true
		emit_signal("on_level_end")
