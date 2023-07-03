extends Node

const moedas = [
	preload("res://scenes/moeda.tscn"),
]

var fim_moedas = false

func _ready():
	yield(get_tree().create_timer(1.2), "timeout")
	spawn()
	pass

func spawn():
	while true:
		randomize()

		var moeda = utils.choose(moedas).instance()
		var moeda_pos = Vector2()
		moeda_pos.x   = rand_range(0+16, utils.view_size.x-16)
		moeda_pos.y   = 0-16
		moeda.position = moeda_pos
		$container.add_child(moeda)
		yield(utils.create_timer(rand_range(2, 5)), "timeout")
		pass
		if fim_moedas:
			return
			moeda
			pass
	pass


func _on_Timer_timeout():
	fim_moedas = true
	pass # Replace with function body.
