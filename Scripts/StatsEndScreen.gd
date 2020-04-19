extends Node2D

onready var global = get_node("/root/global")

func _ready():
	pass
	
func _process(delta):
	$SentenceSaved/LabelGirlSaved.text = str(global.girl_nb_alive) + ' times'
	$SentenceKilled/LabelGirlKilled.text = str(global.girl_nb_killed) + ' times'
	$SentenceCharacter/LabelCharacterAlive.text = str(global.character_nb_alive) + ' alive'
	$SentenceCharacter/LabelCharacterDead.text = str(global.character_nb_killed) + ' dead'
