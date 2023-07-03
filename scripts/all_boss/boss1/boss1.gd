extends EnemyBase

var armor = 100 setget set_armor
onready var armor_inicial = armor
onready var anim := $anim
var anim_atual = ""
var prox_anim = "dormindo"
onready var player = get_node("/root/world/player")
var iniciar_ataque = false

const scn_shot     = preload("res://scenes/all_boss/boss1/espinho_boss.tscn")

func _ready():
	score_value = 1
	add_to_group("enemy")
	
func _process (_delta):
	animar()
	if iniciar_ataque:
		if $Timer.time_left >= 2.8:
			prox_anim = "encolher"
		else:
			prox_anim = "parado"

func set_armor(new_value):
	if is_queued_for_deletion(): return
	$hud/itens/energia_boss.scale = float(armor) / float(armor_inicial)
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
		
func atacar(): #inicia tudo
	$dir_ar.emitting = true
	$esq_ar.emitting = true
	$hud/itens/anim.play("painel_energia")
	
func animar():
	if prox_anim != anim_atual:
		anim_atual = prox_anim
	anim.play(anim_atual)
	
func _on_sensor_iniciar_body_entered(body):
	if body.is_in_group("player"):
		prox_anim = "tamanho"
		yield(get_tree().create_timer(1), "timeout")
		atacar()
		prox_anim = "parado"
		$sensor_iniciar/shape.disabled = true
		iniciar_ataque = true
		
func _on_colidir_com_player_body_entered(body):
	if body.is_in_group("player"):
		body.armor -= 1
		
func create_shot(pos_2D:Position2D):
	for i in 8:
		var shot = scn_shot.instance()
		shot.position = global_position
		match i:
			0: 
				shot.dir = Vector2(1,0)
				shot.rotation_degrees = -90
			1: 
				shot.dir = Vector2(-1,0)
				shot.rotation_degrees = 90
			2: shot.dir = Vector2(0,1)
			3: 
				shot.dir = Vector2(0,-1)
				shot.rotation_degrees = 180
			4: 
				shot.dir = Vector2(1,1)
				shot.rotation_degrees = -45
			5: 
				shot.dir = Vector2(1,-1)
				shot.rotation_degrees = -145
			6: 
				shot.dir = Vector2(-1,-1)
				shot.rotation_degrees = 145
			7:
				shot.dir = Vector2(-1,1)
				shot.rotation_degrees = 45
		get_parent().add_child(shot)

func _on_Timer_timeout():
	if iniciar_ataque:
		create_shot($pos_espinho)
