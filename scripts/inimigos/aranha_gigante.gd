extends EnemyBase

export var armor = 3 setget set_armor
const scn_explosion = preload("res://scenes/efeitos/efeitos_explosivos/morte_inimigos.tscn")

enum State {
	WALKING,
	DEAD
}

var _state = State.WALKING

onready var platform_detector = $PlatformDetector
onready var floor_detector_left = $colidir_esquerda/FloorDetectorLeft
onready var floor_detector_right = $colidir_direita/FloorDetectorRight
var vel_inicial = Vector2(0,15)
const NORMALIZAR_CHAO = Vector2.UP


func _ready():
	score_value = 1
	add_to_group("enemy")


func _physics_process(delta):
	vel_inicial.y  * delta
	move_and_slide(vel_inicial).y
	if vel_inicial.y == -15:
		$sprite.flip_h = false
	elif vel_inicial.y == 15:
		$sprite.flip_h = true
func set_armor(new_value):
	if is_queued_for_deletion(): return
	if new_value < armor: 
		audio_player.play("hit_enemy")
		armor = new_value
	if is_inside_tree():
		$sprite.modulate = Color(10, 10, 10)
		yield(utils.create_timer(0.1), "timeout")
		$sprite.modulate = Color(1, 1, 1, 1)
	
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
	$sprite.show()

func _on_enemy_body_entered(body): 
#colisao com player
	if body.is_in_group("player"):
		body.armor -= 1
		create_explosion()
		queue_free()
		
func pisar_no_inimigo(body): #se o player pisar em cima dele
	if body.is_in_group("player"):
		create_explosion()
		queue_free()

func _on_colidir_direita_body_entered(_body):
	vel_inicial.y = 15

func _on_colidir_esquerda_body_entered(_body):
	vel_inicial.y = -15
