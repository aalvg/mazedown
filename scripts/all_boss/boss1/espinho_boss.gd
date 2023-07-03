extends Area2D

export var dir = Vector2() setget set_dir
var vel = -100

const scn_flare_tiro = preload("res://scenes/efeitos/efeitos_explosivos/circulo_explosivo.tscn")

func _ready():
	pass
	
func _process(delta):
	translate(dir * vel * delta)

func set_dir(val):
	dir = val
	#rotation = dir.angle()

func _on_espinho_boss_body_entered(body):
	if body.is_in_group("blocos"):
		create_flare_tiro()
		queue_free()
	if body.is_in_group("player"):
		body.armor -= 1
		create_flare_tiro()
		queue_free()
		
func create_flare_tiro():
	var flare_tiro = scn_flare_tiro.instance()
	flare_tiro.position = self.position
	utils.main_node.add_child(flare_tiro)
