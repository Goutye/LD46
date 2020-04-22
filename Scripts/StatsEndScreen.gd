extends Node2D

onready var global = get_node("/root/global")

export var max_row_per_time_detail_col1 = 7
export var max_row_per_time_detail_col2 = 5
var _has_display_detail = false

func _ready():
	$SentenceTime/LabelTimeValue.text = get_time_str(global.total_time)
	
func _process(delta):
	$SentenceSaved/LabelGirlSaved.text = str(global.girl_nb_alive) + ' times'
	$SentenceKilled/LabelGirlKilled.text = str(global.girl_nb_killed) + ' times'
	$SentenceCharacter/LabelCharacterAlive.text = str(global.character_nb_alive) + ' alive'
	$SentenceCharacter/LabelCharacterDead.text = str(global.character_nb_killed) + ' dead'
	$SentenceCharacter/LabelCharacterJumps.text = str(global.character_nb_jumps) + ' propulsions'

	if not _has_display_detail:
		display_time_detail()
		_has_display_detail = true
		
	$SentenceTimeDetail.visible = global.display_detail
		

func get_time_str(time):
	var minute = floor(time / 60)
	var second = floor(time - minute * 60)
	var text_second = str(second)
	if second < 10:
		text_second = "0" + text_second
	var text_minute = str(minute)
	if minute < 10:
		text_minute = "0" + text_minute
	return text_minute + ":" + text_second
	
func get_time_ms_str(time):
	var second = floor(time)
	var text_second = str(second)
	var centisecond = floor((time - second) * 100)
	
	if second < 10:
		text_second = "0" + text_second
	var text_centisecond = str(centisecond)
	if centisecond < 10:
		text_centisecond = "0" + text_centisecond
	return text_second + "." + text_centisecond

func display_time_detail():
	var id_level = 0
	for id_level in range(global.time_per_level.size()):
		if id_level >= 23:
			return
		
		var time = global.time_per_level[id_level]
		if id_level > 0:
			time -= global.time_per_level[id_level - 1]
		
		var current_col_id = id_level / max_row_per_time_detail_col1
		var row = id_level % max_row_per_time_detail_col1
		if current_col_id >= 2:
			var id = (id_level - 14)
			current_col_id = 2 + id / max_row_per_time_detail_col2
			row = id % max_row_per_time_detail_col2
			
		var group = $SentenceTimeDetail.get_node("Group" + str(current_col_id + 1))
		
		if row == 0:
			group.visible = true
			group.get_node("LabelNumber").text = ""
			group.get_node("LabelTime").text = ""
		else:
			group.get_node("LabelNumber").text += "\n"
			group.get_node("LabelTime").text += "\n"
		group.get_node("LabelNumber").text += str(id_level + 1)
		group.get_node("LabelTime").text += get_time_ms_str(time)
		
		id_level += 1
		
