extends EnemyBase

export var armor = 5 setget set_armor
const scn_explosion = preload("res://scenes/efeitos/explosion.tscn")
onready var target #= get_node("res://scenes/ship.tscn")
export var vel = 20

var dir_atual := 1.0
var prox_dir := 1.0

func _ready():
	score_value = 1
	add_to_group("enemy")

func _physics_process(delta):
	direcao_sprite()
	if is_inside_tree():
		if target:
			var posicao_ship = target.position
			#$helicoptero.look_at(posicao_ship)
			var direcao = (posicao_ship - position).normalized()
			var rotacao = Vector2(75,75)
			var mover = direcao * vel * delta
			position += mover
			move_and_collide(mover)
			if direcao.x <= 0.1:
				prox_dir = 1
			elif direcao.x >= 0.1:
				prox_dir = -1
	
func _on_sensor_body_entered(body):
	target = body

func _on_sensor_body_exited(body):
	target = null

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
	$caveira/shape.show()
	$rotacao/sprite.show()
	$sensor/shape.show() 

func _on_helicoptero_body_entered(body):
	if body.is_in_group("player"):
		body.armor -= 1
		create_explosion()
		queue_free()
		
func direcao_sprite():
	if prox_dir != dir_atual:
		dir_atual = prox_dir
		$rotacao.scale.x = dir_atual
