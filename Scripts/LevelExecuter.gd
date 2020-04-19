extends Node2D
class_name LevelExecuter

signal on_level_end

var _is_level_ended := false
var _timer_rope : Timer
export var camera_zoom = Vector2(1, 1)

var characters_stats = []

func _ready():
	$Characters/Girl.connect("hit_by_character", self, "_on_girl_hit_by_character")
	
	_timer_rope = Timer.new()
	$Other.add_child(_timer_rope)
	
	for character in $Characters.get_children():
		if character is Character and character.can_track_collisions:
			characters_stats.append(character)

func _process(delta):
	pass
	
func _on_girl_hit_by_character():
	if not _is_level_ended:
		_is_level_ended = true
		emit_signal("on_level_end")
		
		$Other/Rope.detach()
		if $Other.get_node("Rope2") != null:
			_timer_rope.connect("timeout", self, "_on_rope_timer_timeout")
			_timer_rope.start(0.5)
			
func _on_rope_timer_timeout():
	$Other/Rope2.detach()
		
		

func get_nb_collisions():
	var nb_collisions = 0
	for character in characters_stats:
		nb_collisions += character.nb_collisions
	return nb_collisions
