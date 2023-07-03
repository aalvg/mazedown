extends Node2D

const objeto = [
	preload("res://scenes/inimigos/neve/goblin_voador.tscn"),
]

export var pode_spawnar = false
onready var player = get_node("/root/world/player")
var tempo = 0

func _process(_delta):
	if pode_spawnar:
		tempo += _delta
		if tempo >= 20:
			$Timer.wait_time = 1.5
		if not player or $Timer.wait_time <= 2:
			tempo = 0
			#pode_spawnar = false

func _on_Timer_timeout():
	pode_spawnar = true
	if pode_spawnar:
		if player:
			randomize()
			var enemy = utils.choose(objeto).instance()
			var enm_pos = Vector2()
			enm_pos.x   = 0-2
			enm_pos.y   = 0-2 
			enemy.position = enm_pos
			$container.add_child(enemy)
