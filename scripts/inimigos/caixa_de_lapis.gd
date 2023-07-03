extends StaticBody2D
# NAO PODE DAR QUEUE_FREE SO E INSTANCIADO UMA BOLA DE NEVE QUANDO RESETA OS SEGUNDOS DO TIMER
# ELA VOLTA PRA POSICAO ORIGEM ENTAO SO EXISTE UMA SENDO DESNECESSARIO O QUEUE FREE
onready var scn_objeto = $lapis

func _ready():
	_on_Timer_timeout()

func _on_Timer_timeout():
	var objeto = scn_objeto
	objeto.position = $mira.position

