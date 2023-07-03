extends PlayerAnimacoes
class_name Player

func _ready():
	pass

func _physics_process(delta):
	controles()
	fisica_do_personagem(delta)
	player_anim()
	virar_mumia()
	gerenciar_tiro(delta)
	_draw()
