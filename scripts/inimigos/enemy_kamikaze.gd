extends EnemyBase

const scn_fragmentos = preload("res://scenes/efeitos/fragmentos_paredes/fragmentos_paredes.tscn")
const scn_explosion = preload("res://scenes/efeitos/efeitos_explosivos/fumaca_cinza.tscn")
export var armor = 1 setget set_armor
export(int , "pretoebranco", "preto", "gelo", "lego_amarelo", "lego_azul", "lego_laranja", "lego_verde", "lego_vermelho", "madeira", "redfire", "neon") var sprite = 0 setget set_sprite

var modelo_sprite = [
	"res://sprites/inimigos/parede_quebravel.png", #0 preto e branco
	"res://sprites/inimigos/parede_quebravel_black.png", #1 preto
	"res://sprites/inimigos/parede_de_gelo.png",#2 gelo
	"res://sprites/inimigos/quebravel_amarelo.png",#3 lego amarelo
	"res://sprites/inimigos/quebravel_azul.png",#4 lego azul
	"res://sprites/inimigos/quebravel_laranja.png",#5 lego lara
	"res://sprites/inimigos/quebravel_verde.png",#6 lego verde
	"res://sprites/inimigos/quebravel_vermelho.png",#7 lego vermelh
	"res://sprites/inimigos/quebravel_chocolate.png",#8 madeira
	"res://sprites/inimigos/quebravel_redfire.png",#9 fire
	"res://sprites/inimigos/parede_neon.png"#9 neon
]

func _ready():
	#add_to_group("enemy")
	add_to_group("blocos_quebraveis")
	
func _draw():
	$sprite.texture = load(modelo_sprite[sprite])

func _physics_process(_delta):
	if Engine.editor_hint:
		return
	
func set_armor(new_value):
	if is_queued_for_deletion(): return
	if new_value < armor: 
		audio_player.play("hit_enemy")
		armor = new_value
	if armor <= 0:
		criar_fragmentos()
		criar_explosao()
		queue_free()
		
func set_sprite(val):
	sprite = val
	if Engine.editor_hint:
		update()
		
func criar_explosao():
	var explosion = scn_explosion.instance()
	explosion.position = global_position
	utils.main_node.add_child(explosion)
		
func criar_fragmentos():
	var fragmento = scn_fragmentos.instance()
	fragmento.position = $sprite.global_position
	fragmento.scale = scale
	utils.main_node.add_child(fragmento)

	var zero = fragmento.get_node("fragmento1")
	var um = fragmento.get_node("fragmento2")
	var dois = fragmento.get_node("fragmento3")
	var tres = fragmento.get_node("fragmento4")

	#lista ordem paredes: peb 0, preto 1, gelo 2, [lego lego lego lego lego], madeira 8, fire 9
	#lista ordem fragmentos: madeira 0, preto 1, gelo 2, brinquedo 3
	match sprite:
	#preto e branco
		0:
			zero.sprite = 1; um.sprite = 1; dois.sprite = 1; tres.sprite = 1
	#preto
		1:
			zero.sprite = 1; um.sprite = 1; dois.sprite = 1; tres.sprite = 1
	#gelo
		2:
			zero.sprite = 2; um.sprite = 2; dois.sprite = 2; tres.sprite = 2
	#lego
		3,4,5,6,7:
			zero.sprite = 3; um.sprite = 3; dois.sprite = 3; tres.sprite = 3
	#madeira
		8, 9:
			zero.sprite = 0; um.sprite = 0; dois.sprite = 0; tres.sprite = 0
		10:
			zero.sprite = 4; um.sprite = 4; dois.sprite = 4; tres.sprite = 4
		

