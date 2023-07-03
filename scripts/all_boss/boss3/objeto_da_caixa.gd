extends Area2D
# NO PODE DAR QUEUE_FREE SO E INSTANCIADO UMA BOLA DE NEVE QUANDO RESETA OS SEGUNDOS DO TIMER
# ELA VOLTA PRA POSICAO ORIGEM ENTAO SO EXISTE UMA SENDO DESNECESSARIO O QUEUE FREE
export var velocity = Vector2(-200,0)
const scn_explosion = preload("res://scenes/efeitos/explosion.tscn")


func _ready():
	add_to_group("enemy")

func _process(delta):
	translate(velocity * delta)

func _on_bola_de_neve_body_entered(body):
	if body.is_in_group("player"):
		body.armor -= 1
		$sprite.visible = false

func explodir_item():
	var explodir = scn_explosion.instance()
	explodir.position = global_position
	utils.main_node.add_child(explodir)
