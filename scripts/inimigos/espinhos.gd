extends EnemyBase

var velocity = Vector2(0,1)
const scn_explosion = preload("res://scenes/efeitos/explosion.tscn")
var tempo = 0
# Defina um atraso aleatório para cada instância
var delay = rand_range(0, 2.0) # Define um atraso de 0 a 2 segundos
func _ready():


	# Inicie a animação com o atraso
	$anim.play("espinho", delay)
	#$anim.play("espinho")
	score_value = 1
	add_to_group("enemy")
	velocity.x = utils.choose([+velocity.x, -velocity.x])

func create_explosion():
	var explosion = scn_explosion.instance()
	explosion.position = global_position
	utils.main_node.add_child(explosion)

func _on_VisibilityNotifier2D_screen_entered():
	$shape.show()
	$Sprite.show()

func _on_enemy_body_entered(body):
	if body.is_in_group("player"):
		body.armor -= 1
		create_explosion()

func _on_Timer_timeout():
	#position.y = position.y-3
	#if position.y >= position.y-3:
	#	velocity.y = -velocity.y
	#	position.y = position.y+3
	#else:
	#	velocity.y = +velocity.y
	pass
