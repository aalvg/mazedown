extends EnemyBase

const scn_explosion = preload("res://scenes/efeitos/explosion.tscn")
var ativar = false

func _ready():
	score_value = 1
	add_to_group("enemy")
	
func _process(delta):

	if ativar:
		if $varios_danos.get_time_left() >= 2.5:
			$colidir_com_player/shape.disabled = true
		if $varios_danos.get_time_left() <= 2:
			$colidir_com_player/shape.disabled = false

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
		create_explosion()
		ativar = true
