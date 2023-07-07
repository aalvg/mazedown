extends EnemyBase

export var armor = 3 setget set_armor
var barra_de_vida = 3
var max_barra = 3
const scn_morte_inimigo = preload("res://scenes/efeitos/efeitos_explosivos/morte_inimigos.tscn")

enum State {
	WALKING,
	DEAD
}

var _state = State.WALKING

onready var platform_detector = $PlatformDetector
onready var floor_detector_left = $FloorDetectorLeft
onready var floor_detector_right = $FloorDetectorRight
var vel_inicial = Vector2()
const NORMALIZAR_CHAO = Vector2.UP
export var dir = Vector2(50, 350.0)


func _ready():
	$barraVida.max_value = max_barra
	$anim.play("gosma_andando")
	score_value = 1
	add_to_group("enemy")
	vel_inicial.x = dir.x

func _physics_process(_delta):
	$barraVida.value = barra_de_vida
	#vel_inicial.y  * delta
	if not floor_detector_left.is_colliding():
		vel_inicial.x = dir.x
	elif not floor_detector_right.is_colliding():
		vel_inicial.x = -dir.x
	
	if is_on_wall():
		vel_inicial.x *= -1
	vel_inicial.y = move_and_slide(vel_inicial, NORMALIZAR_CHAO).y
		
func set_armor(new_value):
	if is_queued_for_deletion(): return
	if new_value < armor: 
		audio_player.play("hit_enemy")
		armor = new_value
	if is_inside_tree():
		$sprite.modulate = Color(10, 10, 10)
		yield(get_tree().create_timer(0.1), "timeout")
		$sprite.modulate = Color(1, 1, 1, 1)
	
	if armor <= 0:
		#utils.search_node("tex_score").score += score_value
		#efeito_morte()
		ao_destruir()
		queue_free()

func efeito_morte():
	var morte = scn_morte_inimigo.instance()
	morte.position = global_position
	utils.main_node.add_child(morte)

func _on_VisibilityNotifier2D_screen_entered():
	$shape.show()
	$sprite.show()

func pisar_no_inimigo(body): #se o player pisar em cima dele
	if body.is_in_group("player"):
		#efeito_morte()
		queue_free()

func _on_colidir_com_player_body_entered(body):
#colisao com player
	if body.is_in_group("player"):
		body.armor -= 1

