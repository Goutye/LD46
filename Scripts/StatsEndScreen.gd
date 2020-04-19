extends Node2D

onready var global = get_node("/root/global")

func _ready():
	$SentenceTime/LabelTimeValue.text = get_time_str(global.total_time)
	
func _process(delta):
	$SentenceSaved/LabelGirlSaved.text = str(global.girl_nb_alive) + ' times'
	$SentenceKilled/LabelGirlKilled.text = str(global.girl_nb_killed) + ' times'
	$SentenceCharacter/LabelCharacterAlive.text = str(global.character_nb_alive) + ' alive'
	$SentenceCharacter/LabelCharacterDead.text = str(global.character_nb_killed) + ' dead'
	$SentenceCharacter/LabelCharacterJumps.text = str(global.character_nb_jumps) + ' propulsions'

func get_time_str(time):
	var minute = floor(time / 60)
	var second = ceil(time - minute * 60)
	var text_second = str(second)
	if second < 10:
		text_second = "0" + text_second
	var text_minute = str(minute)
	if minute < 10:
		text_minute = "0" + text_minute
	return text_minute + ":" + text_second
