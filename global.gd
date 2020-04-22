extends Node

var total_time = 0
var girl_nb_killed = 0
var girl_nb_alive = 0
var character_nb_killed = 0
var character_nb_alive = 0
var character_nb_jumps = 0

var is_timer_on = true
var display_detail = false

var time_per_level = []

func on_level_start(level_nb):
	is_timer_on = level_nb != 0
	if level_nb == 0 or level_nb == 1:
		reset_stats()
		
	var id_level = level_nb - 1
	if id_level < 0:
		return
	
	if time_per_level.size() > id_level:
		time_per_level[id_level] = total_time
	else:
		time_per_level.append(total_time)

func reset_stats():
	time_per_level = []
	total_time = 0
	girl_nb_killed = 0
	girl_nb_alive = 0
	character_nb_killed = 0
	character_nb_alive = 0
	character_nb_jumps = 0

func _process(delta):
	if is_timer_on:
		total_time += delta
