extends EnemyBase

export var armor = 2 setget set_armor
const scn_morte_inimigo = preload("res://scenes/efeitos/efeitos_explosivos/morte_inimigos_branco.tscn")

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

var pode_virar = true

func _ready():
	$anim.play("gosma_andando")
	score_value = 1
	add_to_group("enemy")
	vel_inicial.x = dir.x

func _physics_process(_delta):

	if !pode_virar:
		$rotacao/CPUParticles2D.emitting = true
	else: $rotacao/CPUParticles2D.emitting = false

	#vel_inicial.y  * delta
	if pode_virar:
		if not floor_detector_left.is_colliding():
			vel_inicial.x = dir.x
		elif not floor_detector_right.is_colliding():
			vel_inicial.x = -dir.x

		if is_on_wall():
			vel_inicial.x *= -1
			
		vel_inicial.y = move_and_slide(vel_inicial, NORMALIZAR_CHAO).y
		
		if vel_inicial.x < 0:
			#$sprite.flip_h = true
			$rotacao.scale.x = -1
		elif vel_inicial.x > 0:
			#$sprite.flip_h = false
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
#colisao com player
	if body.is_in_group("player"):
		body.armor -= 1

func _on_Timer_timeout():
	if !pode_virar:
		pode_virar = true

func _on_colidir_blocos_area_entered(area):
	if area.is_in_group("blocos"):
		pode_virar = false

func _on_colidir_blocos_body_entered(body):
	if body.is_in_group("blocos") or body.is_in_group("player"):
		pode_virar = false
		if body.is_in_group("player"):body.armor -= 1
