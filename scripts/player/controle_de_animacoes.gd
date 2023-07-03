extends PlayerMumia
class_name PlayerAnimacoes

func player_anim():
	# Se estiver no chão...
	if is_on_floor():
		# ...se hpuver movimento suficiente na direção x...
		if abs(direcao.x) > 0.5 && direita or esquerda:
			anim.play("correndo")
			$rotacao.scale.x = 1 if direcao.x > 0 else -1
		else:
			if !atirar_45g && esta_atirando:
				anim.play("dando_tiro")
				anim.seek(0)
				esta_atirando = false
				
			elif anim.current_animation != "dando_tiro":
				anim.play("parado")

			if atirar_45g:
				anim.play("disparo_45g")
				anim.seek(0)
				esta_atirando = false
			elif anim.current_animation != "dando_tiro":
				anim.play("parado")
	# Se não estiver no chão...
	else:
		if esta_atirando:
			anim.play("atirando")
			anim.seek(0)
			esta_atirando = false
		elif anim.current_animation != "atirando":
			anim.play("pulando")
		if abs(direcao.x) > 0.5:
			$rotacao.scale.x = 1 if direcao.x > 0 else -1
