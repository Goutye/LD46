extends Area2D


func _on_Area2D_body_entered(body):
	if body is Girl or body is Character:
		body.on_hit_by_lava()
