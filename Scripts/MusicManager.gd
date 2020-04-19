extends Node2D

onready var musics = [$AudioStreamPlayer, $AudioStreamPlayer2, $AudioStreamPlayer3, $AudioStreamPlayer4]
var level_manager

var volume = -30
var prev_id = -1
var id = -1
var muted = false

func _ready():
	level_manager = get_parent()
	
func mute():
	if not muted:
		id = -1
		prev_id = -1
		for music in musics:
			music.volume_db = -80
	muted = not muted	

func _process(delta):
	if Input.is_action_just_pressed("mute_music"):
		mute()

	if muted:
		return

	var ratio = level_manager.get_time_ratio_before_rope_breaks()
	
	if ratio >= 1:
		if id != -1:
			id = -1
			for music in musics:
				flux.to(music, 0.3, {volume_db = -45}, "absolute").ease("quad", "inout")
	else:
		var next_id = floor(ratio * 4)
		if next_id >= musics.size():
			next_id = musics.size() - 1
		
		if next_id != id:
			id = next_id
			update_all_in()	
		
		
func update_change_pitch(ratio):
	musics[0].pitch_scale = 0.5 + id*0.5
	

func update_all_in():
	if id == 0:
		for i in range(musics.size()):
			if i != id:
				flux.to(musics[i], 0.5, {volume_db = -80}, "absolute").ease("quad", "inout")
	
	flux.to(musics[id], 1, {volume_db = volume}, "absolute").ease("quad", "inout")
	
func update_one_by_on():
	flux.to(musics[id], 1, {volume_db = volume}, "absolute").ease("quad", "inout").oncomplete.append(funcref(self, "on_ease_music_end"))
		
			
func on_ease_music_end():
	flux.to(musics[prev_id], 0.5, {volume_db = -80}, "absolute").ease("quad", "inout")
	prev_id = id
