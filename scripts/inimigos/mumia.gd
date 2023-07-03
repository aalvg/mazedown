extends EnemyBase

export var armor = 4 setget set_armor
const scn_morte_inimigo = preload("res://scenes/efeitos/efeitos_explosivos/morte_inimigos_branco.tscn")

enum State {
	WALKING,
	DEAD
}

var _state = State.WALKING

onready var platform_detector = $PlatformDetector
onready var floor_detector_left = $FloorDetectorLeft
onready var floor_detector_right = $FloorDetectorRight
onready var anim = get_node("anim")

var movimentar
var vel_inicial = Vector2()
const NORMALIZAR_CHAO = Vector2.UP
export var dir = Vector2(30, 350.0)

func _ready():
	score_value = 1
	add_to_group("enemy")
	vel_inicial.x = dir.x
	
func _process(delta):
	pass
	
func _physics_process(_delta):
	if movimentar:
		if not floor_detector_left.is_colliding():
			vel_inicial.x = dir.x
		elif not floor_detector_right.is_colliding():
			vel_inicial.x = -dir.x
		if is_on_wall():
			vel_inicial.x *= -1
		vel_inicial.y = move_and_slide(vel_inicial, NORMALIZAR_CHAO).y

	if vel_inicial.x < 0:
		$rotacao.scale.x = -1
	elif vel_inicial.x > 0:
		$rotacao.scale.x = 1
		
func set_armor(new_value):
	if is_queued_for_deletion(): return
	if new_value < armor: 
		audio_player.play("hit_enemy")
		armor = new_value
	
	if armor <= 0:
		#utils.search_node("tex_score").score += score_value
		efeito_morte()
		ao_destruir()
		queue_free()

func efeito_morte():
	var morte = scn_morte_inimigo.instance()
	morte.position = global_position
	utils.main_node.add_child(morte)

func _on_VisibilityNotifier2D_screen_entered():
	$shape.show()
	$rotacao/sprite.show()

func _on_enemy_body_entered(body): 
	if body.is_in_group("player"):
		body.sprite = 4
		body.velocidade_de_mov_hor = 60
		body.player_mumia = true

func _on_nascer_body_entered(body):
	if body.is_in_group("player"):
		anim.play("nascimento")
		yield(get_node("anim"), "animation_finished")
		anim.play("andando")
		$nascer/shape.disabled = true
		movimentar = true
