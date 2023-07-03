extends CanvasLayer

var controle_posjogo = false

func _on_jogar_de_novo_pressed():
	get_tree().reload_current_scene()
	
func _on_btn_menu_pressed():
	#audio_player.play("Anacronym")
	get_tree().change_scene("res://stages/menu_option.tscn")
	saver.save_bestmoedas()
	
func _input(event):
	if controle_posjogo == true:
		if event.is_action_pressed('ok'):
			get_tree().change_scene("res://stages/menu_option.tscn")
		if event.is_action_pressed('voltar'):
			get_tree().reload_current_scene()
