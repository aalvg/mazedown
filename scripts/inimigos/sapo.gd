extends EnemyBase

var armor = 5 setget set_armor
const scn_explosion = preload("res://scenes/efeitos/explosion.tscn")
const scn_laser = preload("res://scenes/inimigos/cuspi_sapo.tscn")
var ship
export var vel = 30
var dir_atual := 1.0
var prox_dir := 1.0
var anim_atual := ""
onready var anim := $anim
var esta_atirando
var pulando
var prox_anim := "parado"
var gravidade = 200.0
var puxar_gravidade = Vector2(0,45)

func _ready():
	score_value = 1
	add_to_group("enemy")
	shoot()

func _physics_process(delta):
	
	direcao_sprite()
	#puxar_gravidade.y += delta * gravidade
	translate(puxar_gravidade * delta)
	move_and_collide(puxar_gravidade)
	if is_inside_tree():
		if ship:
			var posicao_ship = ship.position
			var direcao = (posicao_ship - position).normalized()
			var mover = direcao * vel * delta
			position += mover
			move_and_collide(mover)
			if direcao.x <= 0.1:
				prox_dir = -1
			elif direcao.x >= 0.1:
				prox_dir = 1
			if not esta_atirando and vel == 30: prox_anim = "andando"
		else:
			if not esta_atirando and vel == 0: prox_anim = "parado"

func _on_sensor_body_entered(body):
	ship = body

func _on_sensor_body_exited(body):
	ship = null
	
func shoot():
	var laser = scn_laser.instance()
	laser.position = $rotacao/cannon.global_position
	if prox_dir == 1: laser.dir = Vector2(-1,0)
	if prox_dir == -1: laser.dir = Vector2(1,0)
	utils.main_node.add_child(laser)

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
	$sapo/shape.show()
	$rotacaosprite.show()
	$sensor/shape.show()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func direcao_sprite(esta_atirando = false):
	if prox_dir != dir_atual:
		dir_atual = prox_dir
		$rotacao.scale.x = dir_atual
	if prox_anim != anim_atual:
		anim_atual = prox_anim
	anim.play(anim_atual)

func _on_sapo_body_entered(other):
	if other.is_in_group("player"):
		other.armor -= 1
		create_explosion()
		queue_free()
	pass
func _on_Timer_timeout():
	if ship:
		esta_atirando = true
		if esta_atirando == true:
			prox_anim = "atirando"
			vel = 0
	else:
		esta_atirando = false
		if not esta_atirando:prox_anim = "parado"
		vel = 30
