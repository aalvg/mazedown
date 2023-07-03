extends PlayerGeral
class_name ControleTiros

export var quantidade_tiros = 3 #tempo que pode atirar
var maximo_tiros = quantidade_tiros
var esta_atirando
var foi_penalizado = false
const tempo_entre_tiros = 0.4


func gerenciar_tiro(delta):
	if $tempo_tiro.is_stopped():
		quantidade_tiros = min(quantidade_tiros+delta, maximo_tiros)
		
		if foi_penalizado:
			foi_penalizado = false
	else:
		if !foi_penalizado:
			quantidade_tiros = max(0.0, quantidade_tiros-delta)
	
	$canvas/energia_laser.scale = ceil(quantidade_tiros) / float(maximo_tiros)
	$canvas/sombra_energia.scale = ceil(quantidade_tiros) / float(maximo_tiros)
	
	if quantidade_tiros > 0.0:
		if is_on_floor():
			if !atirar_45g && atirar_hori && $tempo_tiro.is_stopped():
				$tempo_tiro.start(tempo_entre_tiros)
				esta_atirando = true
				criar_disparo($rotacao/cannos/mira_horizontal)
				
			if atirar_45g && $tempo_tiro.is_stopped():
				$tempo_tiro.start(tempo_entre_tiros)
				esta_atirando = true
				disparo_45g($rotacao/cannos/mira_vertical)
		else: 
			if direcao.y > 0.1 && atirar_vert && $tempo_tiro.is_stopped():
				$tempo_tiro.start(tempo_entre_tiros)
				esta_atirando = true
				criar_disparo($rotacao/cannos/mira_vertical)

	elif !foi_penalizado:
		# Penaliza o jogador por zerar a energia
		foi_penalizado = true
		$tempo_tiro.start(tempo_entre_tiros*3)
		
func criar_disparo(pos_2D:Position2D):
	var projetil = scn_projetil.instance()
	projetil.anim_tiro()
	projetil.position = pos_2D.global_position
	projetil.dir = -pos_2D.global_transform.x
	get_parent().add_child(projetil)
	if !is_on_floor() && direcao.y>0:
		direcao.y = -170
		
		
func disparo_45g(pos_2D:Position2D):
	var projetil45g = scn_projetil.instance()
	projetil45g.anim_tiro()
	projetil45g.position = pos_2D.global_position
	if $rotacao.scale.x == 1:
		projetil45g.dir = Vector2(-1,1)
	else: 
		projetil45g.dir = Vector2(1,1)
	get_parent().add_child((projetil45g))
	if !is_on_floor() && direcao.y>0:
		direcao.y = -170
