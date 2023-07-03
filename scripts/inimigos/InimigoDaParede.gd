extends KinematicBody2D

# Velocidade do movimento
export var velocidade = 30
export var armor = 3 setget set_armor
const scn_morte_inimigo = preload("res://scenes/efeitos/efeitos_explosivos/morte_inimigos_preto.tscn")
# Direção do movimento
var _dir = Vector2.RIGHT
var _mov = Vector2.ZERO

func _ready():
	add_to_group("enemy")
	$anim.play("gosma_nuvem")
	
func _physics_process(delta):
	if !_encontrou_parede(_rotacionar_vector2_90_hor(_dir) * velocidade * delta):
		if _encontrou_parede((_rotacionar_vector2_90_hor(_dir) -_dir) * velocidade * delta):
			_dir = _rotacionar_vector2_90_hor(_dir)			
	if _encontrou_parede(_dir * velocidade * delta):
		_dir = _rotacionar_vector2_90_anti(_dir)
	move_and_collide(_dir * velocidade * delta)
	_posicao_sprite()
	
func _encontrou_parede(ray)->bool:
	if test_move(transform, ray):
		return true
	return false

# Rotaciona o vetor 90 graus no sentido horário.
func _rotacionar_vector2_90_hor(v:Vector2)->Vector2:
	return Vector2(-v.y, v.x)

# Rotaciona o vetor 90 graus no sentido antihorário.
func _rotacionar_vector2_90_anti(v:Vector2)->Vector2:
	return Vector2(v.y, -v.x)
	
func _posicao_sprite():
	if _dir.x != 0:
		$sprite.rotation = 90
	elif _dir.y != 0 :
		$sprite.rotation = 0
	if _dir.x < 0 :
		$sprite.flip_h = true
		$sprite.flip_v = true
	elif _dir.x > 0 :
		$sprite.flip_h = false
		$sprite.flip_v = false
	elif _dir.y > 0 :
		$sprite.flip_h = true
		$sprite.flip_v = true
	elif _dir.y < 0 :
		$sprite.flip_h = false
		$sprite.flip_v = false

func efeito_morte():
	var morte = scn_morte_inimigo.instance()
	morte.position = global_position
	utils.main_node.add_child(morte)
	
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
		efeito_morte()
		queue_free()

func _on_colidir_com_player_body_entered(body):
	if body.is_in_group("player"):
		body.armor -= 1
		queue_free()
