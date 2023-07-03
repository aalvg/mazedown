extends Node

export var score_max = 12
export var id = 1
var num_estrelas = 0
var moedas = 0
onready var player := $player
#apos gameover volta pro menu
var ativar_troca = false
var timer_troca = 0
#apos gameover volta pro menu

func _ready():
	audio_player.player.stop()
	update_label()
	$hud/scene_transition/anim.play("abre")
	yield(get_tree().create_timer(1), "timeout")
	$hud/scene_transition.hide()
	add_to_group("contador_moeda")

func _process(_delta):
	# CHEAT TEMPORÀRIO. APAGAR DEPOIS!!!
	if Input.is_action_pressed("ui_cancel"):
		_on_FIM_area_entered(KinematicBody2D)
	# CHEAT TEMPORÀRIO. APAGAR DEPOIS!!!
	player_morreu(_delta)
	#num_estrelas
	saver.estrelas_por_fase["fase"+str(id)] = calc_estrelas(saver.score_temp, score_max)
	#num_estrelas
	
func player_morreu(_delta):
	if ativar_troca:
		timer_troca += _delta
	if player.armor <= 0:
		$hud/game_over.show()
		ativar_troca = true
		if timer_troca >= 5:
			get_tree().change_scene("res://stages/menu_option.tscn")

func _on_FIM_area_entered(_body):
	if _body.is_in_group("player"):
		$hud/menu_hud/botao_config.hide()
	# CHEAT TEMPORÀRIO. APAGAR DEPOIS!!!
		#num_estrelas = 3
	# CHEAT TEMPORÀRIO. APAGAR DEPOIS!!!
		$hud/contador_moedas/pos_menu.show()
		$hud/contador_moedas/btn_menu.show()
		$hud.controle_posjogo = true #habilita os botoes de jogar de novo ou sair pelo joystick
		saver.estrelas_por_fase["fase"+str(id)] = calc_estrelas(saver.score_temp, score_max)
		saver.score_temp = 0

		if num_estrelas >= 3:
			$hud/contador_moedas/pos_menu/estrela1.show()
			$hud/contador_moedas/pos_menu/estrela2.show()
			$hud/contador_moedas/pos_menu/estrela3.show()
		elif num_estrelas >= 2:
			$hud/contador_moedas/pos_menu/estrela1.show()
			$hud/contador_moedas/pos_menu/estrela2.show()
		elif num_estrelas >= 1:
			$hud/contador_moedas/pos_menu/estrela1.show()
		if moedas >=1:
			saver.bestmoedas += moedas

		player.controles_ativos = false
		player.remove_from_group("player")

func calc_estrelas(score, _score_maxi) -> int:#score
	if score >= score_max:
		num_estrelas = 3
	elif score >= score_max*0.6666:
		num_estrelas = 2
	elif score >= score_max*0.3333:
		num_estrelas = 1
	return num_estrelas
	
func pega_moeda():
	moedas += 1
	update_label()
	if moedas>= moedas:
		$hud/anim_moeda.play("moeda")

func update_label():
	$hud/contador_moedas/moedas.text = str(moedas)
	$hud/contador_moedas/pos_menu/label.text = str(moedas)
	if num_estrelas >= 3:
		mostrar_estrelas_no_hud()

func mostrar_estrelas_no_hud():
	$hud/conseguiu_estrelas.show()

