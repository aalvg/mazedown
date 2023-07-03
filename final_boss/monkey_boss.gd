extends EnemyBase

export var armor = 700 setget set_armor
onready var anim = $anim
var anim_atual = ""
var prox_anim = "macaco_normal"
var tempo = 0
var scn_bullet = preload("res://final_boss/boss_bullet.tscn")
var atirar = null

func _ready():
	score_value = 1
	add_to_group("enemy")
	#$anim.play("esfera")
	
func _physics_process(delta):
	print(tempo)
	animations()
	tempo += delta
	if tempo >= 5:
		prox_anim = "macaco_grande"
	if tempo >= 7:
		prox_anim = "macaco_normal"
	if tempo >= 10:
		prox_anim = "esferas_idle"
	if tempo >= 12:
		prox_anim = "esfera_aberta"
	if tempo >= 15:
		prox_anim = "esferas_juntas"
		tempo = 0


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
		ao_destruir()
		queue_free()

func animations():
	if prox_anim != anim_atual:
		anim_atual = prox_anim
	anim.play(anim_atual)
	
func disparo_bullet(pos):
	var bullet = scn_bullet.instance()
	bullet.position = $_esfera.position
	add_child(bullet)
	
func disparo_bullet2(pos):
	var bullet = scn_bullet.instance()
	bullet.position = $_esfera2.position
	add_child(bullet)

func permite_atirar(): #controlado dentro do anim player
	atirar = true
	
func not_atirar(): #controlado dentro do anim player
	atirar = false

func _on_Timer_timeout():
	if atirar == true:
		disparo_bullet($_esfera.global_position)
		disparo_bullet2($_esfera2.global_position)
