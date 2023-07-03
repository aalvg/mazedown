extends Node2D

var dir = Vector2(0,-1)
export var vel = 30

func _process(delta):
	translate(dir * vel * delta)

func _on_VisibilityNotifier2D_screen_entered():
	get_tree().change_scene("res://stages/config.tscn")

func _on_sair_pressed():
	get_tree().change_scene("res://stages/config.tscn")


func _on_Visibilityzeramento_screen_exited():
	get_tree().change_scene("res://stages/stage_menu.tscn")


func _on_adeus_screen_exited():
	$anim.play("adeus")
