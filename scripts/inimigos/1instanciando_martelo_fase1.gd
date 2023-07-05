extends Node2D

const NUMERO_DE_COPIAS = 1
const DELAY_ENTRE_INSTANCIAS = 1.0  # Tempo de atraso em segundos

func _ready():
	for i in range(NUMERO_DE_COPIAS):
		yield(get_tree().create_timer(DELAY_ENTRE_INSTANCIAS), "timeout")
		
		# Instancia a cena "CenaAnimationPlayer.tscn"
		var cenaAnimationPlayer = load("res://scenes/inimigos/martelo.tscn").instance()

		# Adiciona a instância à cena principal
		add_child(cenaAnimationPlayer)
