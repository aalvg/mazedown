extends Control


func _ready():
	# Coloca o foco no primeiro botão do grid
	$ScrollContainer/VBoxContainer/fases_list.get_child(0).grab_focus()

