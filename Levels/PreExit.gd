extends Area2D



func _on_body_entered(body):
	if body.name == "Player":
		if name == "PreExit":
			var enemy_sound = get_node_or_null("/root/Game/PreExit_sound")
			if enemy_sound != null:
				enemy_sound.play()
			$Confetti.emitting = true
	
