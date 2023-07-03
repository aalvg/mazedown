extends PlayerSkins
class_name PlayerMumia

var mumia = scn_mumia.instance()
export var tempo_mumificado = 0
export var player_mumia = false

func _physics_process(delta):
########## codigo mumia ##########################
	if player_mumia == true:
		tempo_mumificado += delta
		if tempo_mumificado >= 5:
			tempo_mumificado = 0
			player_mumia = false
########## codigo mumia #######################

func virar_mumia():
	if player_mumia == true:
		$rotacao/luzes.hide()
	if player_mumia == false:
		$rotacao/luzes.show()
		sprite = 0
		velocidade_de_mov_hor = 100
