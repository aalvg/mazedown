extends Node2D

var tempo = 0
var disparar_tempo = false

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if disparar_tempo == true:
		tempo += delta
		get_tree().paused = true
	else:
		$anim.stop()
		get_tree().paused = false
	
	if tempo >= 5 :
		$fundo.hide()
		$bolinhas_animadas.hide()
		$pular_text.hide()
		$pular_e_atirar_text2.hide()
		tempo = 0
		$bolinhas_animadas_A.hide()
		$atirar_no_inimigo_text.hide()
		disparar_tempo = false

func _on_pular_body_entered(body):
	$fundo.show()
	$bolinhas_animadas.show()
	$anim.play("bolinhas")
	disparar_tempo = true
	$pular_text.show()
	$pular/CollisionShape2D.queue_free()
	
func _on_atirar_chao_body_entered(body):
	$fundo.show()
	$bolinhas_animadas.show()
	$anim.play("bolinhas")
	disparar_tempo = true
	$pular_e_atirar_text2.show()
	$atirar_chao/CollisionShape2D.queue_free()

func _on_atirar_no_inimigo_body_entered(body):
	$fundo.show()
	$bolinhas_animadas_A.show()
	$anim.play("bolinhasA")
	$atirar_no_inimigo_text.show()
	$atirar_no_inimigo/CollisionShape2D.queue_free()
	disparar_tempo = true

func _on_acabou_body_entered(body):

	get_tree().change_scene("res://stages/stage_game.tscn")
