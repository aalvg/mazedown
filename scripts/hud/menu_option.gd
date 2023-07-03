extends Node

var NUM_FASES = 10

# Número que servirá como sufixo inicial para salvamento do número de estrelas.
# Exemplo:  NUM_INICIAL = 11 começará salvando a primeira fase como "fase11", a
# segunda como "fase12", a terceira como "fase13", etc.
var NUM_SUFIXO_INICIAL_FASES = 1
var NUM_SUFIXO_INICIAL_FALSES = 1

func _ready():
	$hud/fases_list.get_child(0).grab_focus()
	verificar_desbloqueio_de_fases()
	$hud/scene_transition/anim.play("abre")
	yield(get_tree().create_timer(0.350), "timeout")
	$hud/scene_transition.hide()
	#audio_player.play("laser_ship")
	
func verificar_desbloqueio_de_fases():
	var falses = []
	#for i in NUM_FASES:
		#falses.append(get_node("hud/lock_stage/false"+str(NUM_SUFIXO_INICIAL_FASES + i)))
	
	var num_fase
	var num_false
	#for i in NUM_FASES:
		
		#if i == 0:
			#falses[0].hide()
			#get_node("hud/fase_"+str(NUM_SUFIXO_INICIAL_FALSES)).show()
		#else:
		#	num_fase = NUM_SUFIXO_INICIAL_FASES + i - 1
		#	num_false = NUM_SUFIXO_INICIAL_FALSES + i
			
			#if saver.estrelas_por_fase:
			#	if saver.estrelas_por_fase.has("fase"+str(num_fase)):
				#	var num_estr = saver.estrelas_por_fase["fase"+str(num_fase)]
				#	if num_estr != null && num_estr >= falses[i].custo_para_liberar:
				#		falses[i].hide()
					#	get_node("hud/fase_"+str(num_false)).show()
					#	print("hud/fase_"+str(num_false))
					#	continue
						
		#	falses[i].show()
			#get_node("hud/fase_"+str(num_false)).hide()

func _on_fase_1_pressed():
	get_tree().change_scene("res://stages/stage_game.tscn")
func _on_fase_2_pressed():
	get_tree().change_scene("res://stages/stage_game2.tscn")
func _on_fase_3_pressed():
	get_tree().change_scene("res://stages/stage_game3.tscn")

	#BOSS BOSS BOOS BOSS BOSS BOSS BOSS BOOS BOSS BOSS 
func _on_fase_4_pressed():
	get_tree().change_scene("res://stages/boss/stage_boss1.tscn")
	#BOSS BOSS BOOS BOSS BOSS BOSS BOSS BOOS BOSS BOSS 

func _on_fase_5_pressed():
	get_tree().change_scene("res://stages/stage_game4.tscn")
func _on_fase_6_pressed():
	get_tree().change_scene("res://stages/stage_game5.tscn")
func _on_fase_7_pressed():
	get_tree().change_scene("res://stages/stage_game6.tscn")
	
		#BOSS BOSS BOOS BOSS BOSS BOSS BOSS BOOS BOSS BOSS 
func _on_fase_8_pressed():
	get_tree().change_scene("res://stages/boss/stage_boss2.tscn")
		#BOSS BOSS BOOS BOSS BOSS BOSS BOSS BOOS BOSS BOSS 

func _on_fase_9_pressed():
	get_tree().change_scene("res://stages/stage_game7.tscn")
func _on_fase_10_pressed():
	get_tree().change_scene("res://stages/stage_game8.tscn")
func _on_fase_11_pressed():
	get_tree().change_scene("res://stages/stage_game9.tscn")

		#BOSS BOSS BOOS BOSS BOSS BOSS BOSS BOOS BOSS BOSS 
func _on_fase_12_pressed():
	get_tree().change_scene("res://stages/boss/stage_boss3.tscn")
		#BOSS BOSS BOOS BOSS BOSS BOSS BOSS BOOS BOSS BOSS 

func _on_fase_13_pressed():
	get_tree().change_scene("res://stages/stage_game10.tscn")
func _on_fase_14_pressed():
	get_tree().change_scene("res://stages/stage_game11.tscn")
func _on_fase_15_pressed():
	get_tree().change_scene("res://stages/stage_game12.tscn")

		#BOSS BOSS BOOS BOSS BOSS BOSS BOSS BOOS BOSS BOSS 
func _on_fase_16_pressed():
	get_tree().change_scene("res://stages/boss/stage_boss4.tscn")
		#BOSS BOSS BOOS BOSS BOSS BOSS BOSS BOOS BOSS BOSS 

func _on_fase_17_pressed():
	get_tree().change_scene("res://stages/stage_game13.tscn")
func _on_fase_18_pressed():
	get_tree().change_scene("res://stages/stage_game14.tscn")
func _on_fase_19_pressed():
	get_tree().change_scene("res://stages/stage_game15.tscn")

		#BOSS BOSS BOOS BOSS BOSS BOSS BOSS BOOS BOSS BOSS 
func _on_fase_20_pressed():
	get_tree().change_scene("res://stages/boss/stage_boss5.tscn")
		#BOSS BOSS BOOS BOSS BOSS BOSS BOSS BOOS BOSS BOSS 

func _on_fase_21_pressed():
	get_tree().change_scene("res://stages/stage_game16.tscn")
func _on_fase_22_pressed():
	get_tree().change_scene("res://stages/stage_game17.tscn")
func _on_fase_23_pressed():
	get_tree().change_scene("res://stages/stage_game18.tscn")

		#BOSS BOSS BOOS BOSS BOSS BOSS BOSS BOOS BOSS BOSS 
func _on_fase_24_pressed():
	get_tree().change_scene("res://stages/boss/stage_boss6.tscn")
		#BOSS BOSS BOOS BOSS BOSS BOSS BOSS BOOS BOSS BOSS 

func _on_fase_25_pressed():
	get_tree().change_scene("res://stages/stage_game19.tscn")
func _on_fase_26_pressed():
	get_tree().change_scene("res://stages/stage_game20.tscn")
func _on_fase_27_pressed():
	get_tree().change_scene("res://stages/stage_game21.tscn")

		#BOSS BOSS BOOS BOSS BOSS BOSS BOSS BOOS BOSS BOSS 
func _on_fase_28_pressed():
	get_tree().change_scene("res://stages/boss/stage_boss7.tscn")
		#BOSS BOSS BOOS BOSS BOSS BOSS BOSS BOOS BOSS BOSS 

func _on_fase_29_pressed():
	get_tree().change_scene("res://stages/stage_game22.tscn")

		#BOSS BOSS BOOS BOSS BOSS BOSS BOSS BOOS BOSS BOSS 
func _on_fase_30_pressed():
	get_tree().change_scene("res://stages/boss/stage_boss8.tscn")
		#BOSS BOSS BOOS BOSS BOSS BOSS BOSS BOOS BOSS BOSS 

func _on_back_pressed():
	get_tree().change_scene("res://stages/stage_menu.tscn")
func _on_config_pressed():
	#get_tree().change_scene("res://stages/config.tscn")
	pass

#JOYSTICKS
func _input(event):
	if event.is_action_pressed("iniciar"):
		#print("press")
		get_tree().change_scene("res://stages/menu_option.tscn")
	if event.is_action_pressed("voltar"):
		get_tree().change_scene("res://stages/stage_menu.tscn")

