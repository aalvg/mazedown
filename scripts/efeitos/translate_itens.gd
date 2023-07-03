extends Node2D

var dir = Vector2(0,-1)
export var vel = 75

func _process(delta):
	translate(dir * vel * delta)

#func _on_parar_de_andar_area_entered(area):
	#vel = 0

