extends ColorRect

onready var tamanho_barra = rect_size
var scale = 1 setget set_scale

func _ready():
	pass

func set_scale(val):
	scale = val
	rect_size.x = tamanho_barra.x * scale
