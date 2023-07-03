extends Node2D

func _ready():
	$anim.play("intro")
	yield( get_node("anim"), "animation_finished")
	get_tree().change_scene("res://stages/stage_menu.tscn")
	pass
