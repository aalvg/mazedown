extends Area2D

func _on_moeda_no_spawner_body_entered(_body):
	$shape.queue_free()
	$sprite.visible = false
	collision_mask = 0
	audio_player.play("besouro_coin")
	$queue_timer.start()
	$particles.emitting = true
	get_tree().call_group("contador_moeda", "pega_moeda")

func _on_queue_timer_timeout():
	queue_free()

func _on_VisibilityNotifier2D_screen_entered():
	$shape.show()
	$sprite.show()


