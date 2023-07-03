extends EnemyBase

export var armor = 5 setget set_armor
const scn_explosion = preload("res://scenes/efeitos/explosion.tscn")

func _ready():
	$anim.play("minhoca")
	score_value = 1
	add_to_group("enemy")
	
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

func create_explosion():
	var explosion = scn_explosion.instance()
	explosion.position = global_position
	utils.main_node.add_child(explosion)

func _on_colidir_com_player_body_entered(body):
	if body.is_in_group("player"):
		body.armor -= 1
