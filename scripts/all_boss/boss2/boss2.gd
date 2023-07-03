extends EnemyBase

var armor = 100 setget set_armor
var armor_inicial = armor
const scn_tiro = preload ("res://scenes/all_boss/boss2/tiro_boss2.tscn")
const scn_iris_tiro = preload ("res://scenes/all_boss/boss2/iris_tiro.tscn")
var atacar = false

func _ready():
	add_to_group("enemy")

func ataque_iris_mini(_pos):
	randomize()
	var array = [$olhos/olho_mini, $olhos/olho_mini2,
	 $olhos/olho_mini3, $olhos/olho_mini4, $olhos/olho_mini, 
	$olhos/olho_medio, $olhos/olho_medio2,
	$olhos/olho_pequeno, $olhos/olho_pequeno2,
	 $olhos/olho_pequeno3, $olhos/olho_pequeno4,$olhos/olho_parede]
	
	var tiro = scn_tiro.instance()
	var escolha = array[randi()%array.size()]
	var tiro_pos = escolha.position
	tiro.position = tiro_pos
	tiro.scale = escolha.scale
	add_child(tiro)

	var iris_tiro = scn_iris_tiro.instance()
	iris_tiro.position = tiro.position
	iris_tiro.scale = escolha.scale
	add_child(iris_tiro)
	
func _on_tempo_irismini_timeout():
	ataque_iris_mini(position)

func set_armor(new_value):
	if is_queued_for_deletion(): return
	#$hud/itens/energia_boss.scale = float(armor) / float(armor_inicial)
	if new_value < armor: 
		#audio_player.play("hit_enemy")
		armor = new_value
	if is_inside_tree():
		$sprite.modulate = Color(10, 10, 10)
		yield(get_tree().create_timer(0.1), "timeout")
		$sprite.modulate = Color(1, 1, 1, 1)
	if armor <= 0:
		#utils.search_node("tex_score").score += score_value
		ao_destruir()
		queue_free()


func _on_dano_no_player_body_entered(body):
	if body.is_in_group("player"):
		body.armor -= 1
