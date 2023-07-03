extends KinematicBody2D
class_name EnemyBase
onready var score_value = 1
onready var score_value_botao = 3
func ao_destruir():
	saver.score_temp += score_value
	
func ao_destruir_botao():
	saver.score_temp = score_value_botao
	
	
	

