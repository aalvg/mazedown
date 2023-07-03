extends EnemyBase
#O TEMPO DE ATAQUE ESTÁ ATRELADO AO ANIMATION PLAYER

var armor = 5 setget set_armor
const scn_shot = preload("res://scenes/inimigos/inimigos_obj/tiro_abelha.tscn")
const scn_explosion = preload("res://scenes/efeitos/efeitos_explosivos/morte_inimigos.tscn")
onready var target = get_node("/root/world/player")
onready var anim := $anim
var next_anim = "voando"
var current_anim = ""
var atacar = false
var descer = true

var mover = Vector2()
var vel = 10

func _ready():
	score_value = 1
	add_to_group("enemy")

func _physics_process(delta):
	animation()
	if atacar:
		next_anim = "atacando"
	else: next_anim = "voando"
	movimento(delta)
	
func movimento(delta):
	if scale.x != 1:
		mover = Vector2(-1,1)
	else: mover = Vector2(1,1)
	if atacar:
		if descer:
			mover * vel * delta
			translate(mover)
			yield(get_tree().create_timer(0.2), "timeout")
			descer = false

func _on_sensor_body_entered(body):
	if body.is_in_group("player"):
		atacar = true

func _on_sensor_body_exited(_body):
	if _body.is_in_group("player"):
		atacar = false
	
func set_armor(new_value):
	if is_queued_for_deletion(): return
	if new_value < armor: 
		audio_player.play("hit_enemy")
		armor = new_value
	if armor <= 0:
		utils.search_node("tex_score").score += score_value
		create_explosion()
		ao_destruir()
		queue_free()

func create_explosion():
	var explosion = scn_explosion.instance()
	explosion.position = global_position
	utils.main_node.add_child(explosion)

func _on_voar_body_entered(body):
	if body.is_in_group("player"):
		body.armor -= 1
		create_explosion()
		queue_free()

func create_shot():
	var shot_pos = [$pos.position, $pos2.position, $pos3.position, $pos4.position]
	if atacar:
		for i in shot_pos:
			var shot = scn_shot.instance()
			shot.position = i
			if scale.x == 1:
				shot.dir = Vector2(1,1)
			else: shot.dir = Vector2(1,1)
			add_child(shot)

func animation():
	if next_anim != current_anim:
		current_anim = next_anim
	anim.play(next_anim)
