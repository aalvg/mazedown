extends EnemyBase

export var armor = 3 setget set_armor
var velocity = Vector2(0,1)
const scn_explosion = preload("res://scenes/efeitos/efeitos_explosivos/morte_inimigos_preto.tscn")
var tempo = 0

func _ready():
	$anim.play("espinho")
	score_value = 1
	add_to_group("enemy")
	velocity.x = utils.choose([+velocity.x, -velocity.x])

func create_explosion():
	var explosion = scn_explosion.instance()
	explosion.position = global_position
	utils.main_node.add_child(explosion)

func _on_VisibilityNotifier2D_screen_entered():
	$shape.show()
	$sprite.show()

func _on_enemy_body_entered(body):
	if body.is_in_group("player"):
		body.armor -= 1

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
		utils.search_node("tex_score").score += score_value
		create_explosion()
		ao_destruir()
		queue_free()
