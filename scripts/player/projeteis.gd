extends Area2D

var max_dist = 170
var live_laser = true
onready var init_pos = global_position
export var dir = Vector2() setget set_dir
var vel = -300
var poder_Slaser = false

const scn_flare_tiro = preload("res://scenes/efeitos/efeitos_explosivos/explosao_tiro_player.tscn")
const scn_explosao_parede = preload("res://scenes/efeitos/efeitos_explosivos/circulo_explosivo.tscn")

func _ready():
	carregar_distancia_tiro()

func carregar_distancia_tiro():
	if saver.dados:
		if saver.itens.has("veloc1") && saver.itens["veloc1"]:
			max_dist = 135
			if saver.itens.has("veloc2") && saver.itens["veloc2"]:
				max_dist = 150
				if saver.itens.has("veloc3") && saver.itens["veloc3"]:
					max_dist = 170
					if saver.itens.has("veloc4") && saver.itens["veloc4"]:
						max_dist = 250
		
func _process(delta):
	translate(dir * vel * delta)
	if live_laser:
		if global_position.distance_to(init_pos) > max_dist:
			live_laser = false
			queue_free()

func set_dir(val):
	dir = val
	rotation = dir.angle()
	if dir.x < 0.1: 
		$sprite_caveira.flip_v = false
	else:
		$sprite_caveira.flip_v = true
func create_flare_tiro():
	var flare_tiro = scn_flare_tiro.instance()
	flare_tiro.position = self.position
	utils.main_node.add_child(flare_tiro)
	
func criar_explosao_parede():
	var explosao_parede = scn_explosao_parede.instance()
	explosao_parede.position = self.position
	utils.main_node.add_child(explosao_parede)

func _on_laser_ship_body_entered(_body):
	criar_explosao_parede()
	#get_tree().call_group("camera", "shake", 0.02 , 0.2) #3 , 0.3 intensidade e depois tempo
	queue_free()
	if _body.is_in_group("blocos_quebraveis"):
		_body.armor -= 1
		criar_explosao_parede()
		queue_free()
		
func _on_laser_ship_enemy_entered(body):
	if body.is_in_group("enemy"):    
		body.armor -= 1
		body.barra_de_vida -= 1
		get_tree().call_group("camera", "shake", 1 , 0.3) #3 , 0.3 intensidade e depois tempo
		criar_explosao_parede()
		if body.armor == 0:		
			create_flare_tiro()
			yield(get_tree().create_timer(1.0), "timeout")
			queue_free()

	if body.is_in_group("paredes"):
		queue_free()
	
func anim_tiro():
	$anim.play("escala_tiro")
