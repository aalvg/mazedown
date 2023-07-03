extends Node

const powerups = [
	preload("res://scenes/powerup_armor.tscn"),
	preload("res://scenes/powerup_laser.tscn"),
]
var fim_powerups = false

func _ready():
	yield(get_tree().create_timer(rand_range(10, 15)), "timeout")
	spawn()
	pass

func spawn():
	while true:
		randomize()

		var enemy = utils.choose(powerups).instance()
		var enm_pos = Vector2()
		enm_pos.x   = rand_range(0+7, utils.view_size.x-7)
		enm_pos.y   = 0-7
		enemy.position = enm_pos
		$container.add_child(enemy)
		yield(utils.create_timer(rand_range(8, 12)), "timeout")
		pass
		if fim_powerups:
			return
# warning-ignore:unreachable_code
# warning-ignore:standalone_expression
# warning-ignore:unreachable_code
			enemy
			pass
	pass


func _on_Timer_timeout():
	fim_powerups = true
	pass # Replace with function body.
