extends Area2D

func _on_body_entered(other):
	if other.is_in_group("blocos_quebraveis"):
		$Light2D.hide()
	if other.is_in_group("player"):
		other.armor += 1
		audio_player.play("powerup")
		$Light2D.hide()
		$sprite.visible = false
		$sprite_coracao.visible = false
		collision_mask = 0
		$particles.emitting = true
		$queue_timer.start()

func _on_powerup_armor_body_exited(body):
	if body.is_in_group("blocos_quebraveis"):
		$Light2D.show()
		
func _on_queue_timer_timeout():
	queue_free()
	$Light2D.show()





