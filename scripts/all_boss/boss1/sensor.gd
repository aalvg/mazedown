extends Area2D

func _on_sensor_body_entered(body):
	if body.is_in_group("player"):
		$"../spawner_box".pode_spawnar = true

