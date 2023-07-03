extends Area2D

func _on_body_entered(other):
	if other.is_in_group("player"):
		other.duplo_tiro = true
		audio_player.play("powerup")
		$sprite.visible = false
		collision_mask = 0
		$queue_timer.start()
		$particles.emitting = true

func _on_queue_timer_timeout():
	queue_free()

