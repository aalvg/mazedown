extends EnemyBase

export var armor = 1 setget set_armor
const scn_explosion = preload("res://scenes/efeitos/explosion.tscn")

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
var dir_atual := 1.0
var prox_dir := 1.0

func _ready():
	$anim.play("gosma_andando")
	score_value = 1
	add_to_group("enemy")
	vel_inicial.x = dir.x

func _physics_process(delta):
	direcao_sprite ()
	vel_inicial.y  * delta
	
	if not floor_detector_left.is_colliding():
		vel_inicial.x = dir.x
	elif not floor_detector_right.is_colliding():
		vel_inicial.x = -dir.x
		
	if vel_inicial.x == 50:prox_dir = 1
	elif vel_inicial.x == -50:prox_dir = -1
	
	if is_on_wall():
		vel_inicial.x *= -1
	vel_inicial.y = move_and_slide(vel_inicial, NORMALIZAR_CHAO).y
	
func direcao_sprite ():
	if prox_dir != dir_atual:
		dir_atual = prox_dir
		$rotacao.scale.x = dir_atual
		
func set_armor(new_value):
	if is_queued_for_deletion(): return
	if new_value < armor: 
		audio_player.play("hit_enemy")
		armor = new_value
	if is_inside_tree():
		$rotacao/sprite.modulate = Color(10, 10, 10)
		yield(get_tree().create_timer(0.1), "timeout")
		$rotacao/sprite.modulate = Color(1, 1, 1, 1)
	
	if armor <= 0:
		utils.search_node("tex_score").score += score_value
		create_explosion()
		ao_destruir()
		queue_free()

func create_explosion():
	var explosion = scn_explosion.instance()
	explosion.position = global_position
	utils.main_node.add_child(explosion)

func _on_VisibilityNotifier2D_screen_entered():
	$shape.show()
	$rotacao/sprite.show()

func _on_enemy_body_entered(body): 
#colisao com player
	if body.is_in_group("player"):
		body.armor -= 1
		create_explosion()
		
func pisar_no_inimigo(body): #se o player pisar em cima dele
	if body.is_in_group("player"):
		create_explosion()
		queue_free()
