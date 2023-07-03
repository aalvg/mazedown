extends KinematicBody2D
export var armor = 3 setget set_armor
const scn_morte_inimigo = preload("res://scenes/efeitos/efeitos_explosivos/esfarelar_inimigos.tscn")
const scn_bomba = preload("res://scenes/inimigos/neve/bomba_goblin.tscn")

enum State {
	WALKING,
	DEAD
}

var _state = State.WALKING

onready var floor_detector_left = $FloorDetectorLeft
onready var floor_detector_right = $FloorDetectorRight
onready var floor_detector_floor = $FloorDetectorFloor
var velocity = Vector2(30,0)
var gravidade = Vector2()
var pode_atirar = false
var pode_voar = false

func _ready():
	#score_value = 1
	add_to_group("enemy")

func _physics_process(_delta):
	
	move_and_slide(velocity, Vector2())
	if  floor_detector_left.is_colliding():
		velocity.x = abs(velocity.x)
		$rotacao.scale.x = 1
	elif  floor_detector_right.is_colliding():
		velocity.x = -abs(velocity.x)
		$rotacao.scale.x = -1
	if  floor_detector_floor.is_colliding():
		gravidade.y = 0
		$anim.play("goblin_andando")
		pode_atirar = false
	else: 
		$anim.play("goblin_voando")
		if pode_voar:
			gravidade.y = 0.3
			pode_atirar = true

	translate(gravidade)
	

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
		#utils.search_node("tex_score").score += score_value
		efeito_morte()
		#ao_destruir()
		queue_free()

func efeito_morte():
	var morte = scn_morte_inimigo.instance()
	morte.position = global_position
	utils.main_node.add_child(morte)
	
func atirar(pos_2D:Position2D):
	var bomba = scn_bomba.instance()
	bomba.position = pos_2D.global_position
	bomba.anim()
	utils.main_node.add_child(bomba)

func _on_VisibilityNotifier2D_screen_entered():
	pode_voar = true

func _on_Timer_timeout():
	if pode_atirar:
		atirar($rotacao/cannos/Position2D)

func _on_colidir_com_player_body_entered(body):
	if body.is_in_group("player"):
		body.armor -= 1
