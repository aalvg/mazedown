extends Node

const enemies = [
	preload("res://scenes/powerups_and_spawners/powerup_armor.tscn"),
]
var enemy = true
var fim_enemys = false

func _ready():
	yield(get_tree().create_timer(1.2), "timeout")
	spawn()
	pass

func spawn():
	randomize()

	enemy = utils.choose(enemies).instance()
	var enm_pos = Vector2()
	enm_pos.x   = rand_range(0+16, utils.view_size.x-16)
	enm_pos.y   = 0-16
	enemy.position = enm_pos
	$container.add_child(enemy)
	pass

	if fim_enemys:
		return
		enemy
		pass
		
func _on_Timer_timeout():
	fim_enemys = true
	pass # Replace with function body.
