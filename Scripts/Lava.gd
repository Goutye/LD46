extends Area2D


func _on_Area2D_body_entered(body):
	if body is Girl or body is Character:
		if not body.is_dead:
			body.on_hit_by_lava()
			if not $AudioStreamPlayer2D.is_playing():
				$AudioStreamPlayer2D.play()
				$FireParticles.emitting = true
