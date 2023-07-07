extends KinematicBody2D
class_name PlayerGeral

const scn_mumia = preload("res://scenes/inimigos/80s/mumia.tscn")
const scn_projetil     = preload("res://scenes/player/player_projeteis.tscn")
const scn_poeira = preload("res://scenes/player/poeira.tscn" )
const scn_poeira_andando = preload("res://scenes/player/poeira_andando.tscn" )

export var armor = 4 setget set_armor #quantidade de vidas do player
export var vel_pulo = -300
export var gravidade = 800
var direcao = Vector2()
export var velocidade_de_mov_hor = 100

onready var anim := $rotacao/anim


#controles
var controles_ativos = true
var esquerda
var direita
var pular
var atirar_hori 
var atirar_vert
var atirar_45g 
#controles

signal armor_changed

#tempestade_areia
export var afetado_pel_vento = false
export var vel_vento = 60.0
export var direcao_vento = Vector2(-1, 0)
onready var tem_vento #se tiver o sprite de areia na cena ativa o afetado pelo vento
onready var tem_martelo #se tiver o sprite de martelo na cena ativa o efeito da martelada
export var martelada = false

func _ready():
	#tempestade_areia
	if has_node("/root/world/ParallaxBackground/areia"):
		tem_vento = get_node("/root/world/ParallaxBackground/areia")
	else: tem_vento = null
	if tem_vento:
		afetado_pel_vento = true
	#tempestade_areia
	if Engine.editor_hint:
		return
	
func controles():
	if controles_ativos:
		direita = Input.is_action_pressed('ui_right')
		esquerda = Input.is_action_pressed('ui_left')
		pular = Input.is_action_just_pressed("ui_up")
		atirar_hori = Input.is_action_pressed("fire")
		atirar_45g = Input.is_action_pressed("ui_down")
		atirar_vert = Input.is_action_pressed("ui_up") #o mesmo de pular
	
func fisica_do_personagem(delta):
	direcao.y += gravidade * delta
	if is_on_floor():
		if pular:
			direcao.y = vel_pulo
	else:
		pass
	direcao.x = (velocidade_de_mov_hor * int(direita)) - (velocidade_de_mov_hor * int(esquerda))
	direcao = move_and_slide( (direcao+(vel_vento*direcao_vento)) if afetado_pel_vento else direcao , Vector2.UP)
	
func set_armor(new_value): #quantidade de vidas do personagem
	if new_value > 8    : return
	if new_value < armor:
		
		audio_player.play("hit_ship")
		$flash.show()
		$flash/anim.play("fade_out")
		Input.start_joy_vibration(0, 0.1, 0.0, 0.3) #vibracao do joystick
		get_tree().call_group("camera", "shake", 3 , 0.3) #3 , 0.3 intensidade e depois tempo
	armor = new_value
	emit_signal("armor_changed", armor)
	if armor <= 0:
		controles_ativos = false
		$rotacao/sprite.hide()
		$rotacao/morte.show()
		anim.play("morte")
		yield(get_tree().create_timer(1.0), "timeout")
		Input.vibrate_handheld(500)
		get_tree().call_group("camera", "shake", 3 , 0.3) #3 , 0.3 intensidade e depois tempo
		Input.start_joy_vibration(0, 1.0, 0.0, 1.0) #vibracao do joystick
		remove_from_group("player")
		

func criar_poeira():
	var scales =  [Vector2(0,0),Vector2(0,-1),Vector2(1,1),Vector2(-1,1)]
	for i in scales:
		var poeira = scn_poeira.instance()
		poeira.scale = i
		add_child(poeira)

func criar_poeira_andando():
	var poeira = scn_poeira_andando.instance()
	poeira.scale.x = -$rotacao.scale.x
	poeira.position = position
	if is_on_floor():get_parent().add_child(poeira) 
	
func tomou_martelada():
	if has_node("/root/world/martelo"):
		tem_martelo = get_node("/root/world/martelo")
	else: tem_martelo = null
	if martelada == true:
		$rotacao/sprite.hide()
		$rotacao/player_martelo.show()
		
func fim_martelada():
	if martelada == false:
		$rotacao/sprite.show()
		$rotacao/player_martelo.hide()
