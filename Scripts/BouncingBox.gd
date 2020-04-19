extends StaticBody2D
class_name BouncingBox

func play_sound():
	var random =  randi() % $AudioBoing.get_child_count()
	$AudioBoing.get_child(random).play()
