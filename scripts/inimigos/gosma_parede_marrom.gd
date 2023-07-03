extends KinematicBody2D

var _dir = Vector2.DOWN
var velocidade = 80
var _mov = Vector2.ZERO 
var assobio = false
onready var colisor := $shape
onready var target

func _ready():
	target = get_node("/root/world/player")
	add_to_group("flecha")
	
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
	if _dir.x > 0 or _dir.x < 0:
		rotation = 0
		#$shape.rotation_degrees = -90
		$colidir_com_player.rotation_degrees = -90
	elif _dir.y < 0 or _dir.y > 0:
		rotation = -33
		#$shape.rotation_degrees = 0
		$colidir_com_player.rotation_degrees = 0
	#if _dir.y != 0 :
		#$sprite.rotation = 0
	if _dir.x < 0 :
		$sprite.flip_h = true
	elif _dir.x > 0 :
		$sprite.flip_h = false
	elif _dir.y > 0 :
		$sprite.flip_h = true
	elif _dir.y < 0 :
		$sprite.flip_h = false
		

func _on_colidir_com_player_body_entered(body):
	if body.is_in_group("player"):
		body.armor -= 1

func _on_VisibilityNotifier2D_screen_entered():
	assobio = true
	nao_tem_colisor()

func _on_VisibilityNotifier2D_screen_exited():
	assobio = false
	tem_colisor()
	
func tem_colisor():
	colisor.disabled = false
	
func nao_tem_colisor():
	colisor.disabled = true
