extends Node2D
class_name LevelExecuter

signal on_level_end(is_alive)

var _is_level_ended := false
var _timer_rope : Timer
var _timer_save_girl : Timer
export var time_save_girl = 2.5
export var camera_zoom = Vector2(1, 1)
export var rope_time = 10

var characters_stats = []

func _ready():
	$Characters/Girl.connect("hit_by_character", self, "_on_girl_hit_by_character")
	$Characters/Girl.connect("has_died", self, "_on_girl_died")
	
	_timer_rope = Timer.new()
	_timer_rope.one_shot = true
	$Other.add_child(_timer_rope)
	_timer_save_girl = Timer.new()
	_timer_save_girl.one_shot = true
	$Other.add_child(_timer_save_girl)
	_timer_save_girl.connect("timeout", self, "_on_timer_save_girl_timeout")
	
	for character in $Characters.get_children():
		if character is Character and character.can_track_collisions:
			characters_stats.append(character)
			
	$Other/Rope.rope_time = rope_time
	if $Other.get_node("Rope2") != null:
		$Other/Rope2.rope_time = rope_time

func _process(delta):
	if Input.is_action_just_pressed("detach_rope"):
		$Other/Rope.detach()
	
func _on_girl_hit_by_character():
	if _timer_save_girl.is_stopped():
		_timer_save_girl.start(time_save_girl)
		
		$Other/Rope.detach()
		if $Other.get_node("Rope2") != null:
			_timer_rope.connect("timeout", self, "_on_rope_timer_timeout")
			_timer_rope.start(0.5)

func _on_timer_save_girl_timeout():
	if not _is_level_ended:
		_is_level_ended = true

		global.girl_nb_alive += 1
		for character in $Characters.get_children():
			if character is Character:
				if not character.is_dead:
					global.character_nb_alive += 1

		emit_signal("on_level_end", true)
			
func _on_girl_died():
	if not _is_level_ended:
		_is_level_ended = true
		emit_signal("on_level_end", false)	
	
func _on_rope_timer_timeout():
	$Other/Rope2.detach()
		
		
func get_nb_collisions():
	var nb_collisions = 0
	for character in characters_stats:
		nb_collisions += character.nb_collisions
	return nb_collisions
