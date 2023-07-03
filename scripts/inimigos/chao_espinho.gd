extends StaticBody2D

var pisar

func _process(_delta):
	if pisar:
		$sprite.visible = false
		$sprite_menor.visible = true
		yield(get_tree().create_timer(2), "timeout")
		$spt.visible = true
		if $spt.visible == true:
			$atingir_player/col.disabled = false
			$sprite_menor.visible = false
			$sprite.visible = false
	else:
		$atingir_player/col.disabled = true
		$sprite.visible = true
		$spt.visible = false
		
func _on_chao_espinho_body_entered(body):
	if body.is_in_group("player"):
		pisar = true

func _on_chao_espinho_body_exited(_body):
		pisar = false

func _on_atingir_player_body_entered(body):
	if body.is_in_group("player"):
		body.armor -= 1
