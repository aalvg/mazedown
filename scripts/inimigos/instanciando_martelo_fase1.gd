extends Node2D

const NUMERO_DE_COPIAS = 6

func _ready():
	for i in range(NUMERO_DE_COPIAS):
		# Instancia a cena "CenaAnimationPlayer.tscn"
		var cenaAnimationPlayer = load("res://scenes/inimigos/espinhos.tscn").instance()

		# Adiciona a instância à cena principal
		add_child(cenaAnimationPlayer)
		print("tá instanciando")
