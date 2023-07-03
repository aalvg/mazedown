extends Node2D

const objeto = [
	preload("res://scenes/all_boss/boss3/shot_boss3.tscn"),
]

export var spawnar = false
onready var boss = get_node("/root/world/boss3")
var tempo = 0

func _process(_delta):
	if spawnar:
		
	#	tempo += _delta
		#if tempo >= 15:
			#$Timer.wait_time = 4
		#if tempo >= 25:
		#	$Timer.wait_time = 3
		#if tempo >= 35:
			#$Timer.wait_time = 2
		#if tempo >= 50:
		#	$Timer.wait_time = 1
		if not boss:
			#tempo = 0
			spawnar = false

func _on_Timer_timeout():
	if spawnar:
		if boss:
			randomize()
			var enemy = utils.choose(objeto).instance()
			var enm_pos = Vector2()
			enm_pos.x   = rand_range(0+1, utils.view_size.x-1)
			enm_pos.y   = 0-2
			enemy.position = enm_pos
			$container.add_child(enemy)
