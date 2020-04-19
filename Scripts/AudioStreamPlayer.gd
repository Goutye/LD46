extends AudioStreamPlayer

func _ready():
	pass
func _on_AudioStreamPlayer_finished():
	play()
