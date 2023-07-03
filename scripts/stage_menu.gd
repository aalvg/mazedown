extends Node

onready var animator := $Node2D/anim
func _ready():
	#audio_player.play("menu")
	$hud/scene_transition/anim.play("abre")
	#$Node2D/anim.play("intro") DANDO ERRO

func _on_btn_start_pressed():
		get_tree().change_scene("res://stages/menu_option.tscn")

func _on_btn_quit_pressed():
	get_tree().quit()
	
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "intro":
		animator.play("logo_efeito")
		
#JOYSTICKS

func _input(event):
	if event is InputEventKey or event.is_action_pressed("ok"):
		#print("press")
		get_tree().change_scene("res://stages/menu_option.tscn")
	if event.is_action_pressed("voltar"):
		get_tree().quit()
		
