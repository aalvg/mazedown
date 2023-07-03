extends Node2D

onready var target
const scn_disparo = preload("res://scenes/all_boss/boss2/tiro_boss2.tscn")

func _ready():
	$anim.play("mov_olho")

func _physics_process(_delta):
	#TIMER DO EFEITO DE DISPARO DO OLHO
	if target:
		if $Timer.get_time_left() <= 0.3:
			$anim.play("pre_tiro")
	#TIMER DO EFEITO DE DISPARO DO OLHO

	if target:
		$sprite/Node2D.look_at(target.position)
		$sprite/Node2D/AnimatedSprite.rotation = -$sprite/Node2D.rotation
		$sprite/Node2D/circulo_vermelho.rotation = -$sprite/Node2D.rotation
		$sprite/Node2D/pre_tiro.rotation = -$sprite/Node2D.rotation

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"): 
		target = get_node("/root/world/player")
	
func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		target = null
	
func atirar():
	var disparo = scn_disparo.instance()
	if target:
		disparo.position = position
		disparo.scale =  Vector2(0.6, 0.6)
		disparo.vel = 30
		disparo.dir = Vector2(cos($sprite/Node2D.rotation), sin($sprite/Node2D.rotation))
		get_parent().call_deferred("add_child", disparo)

	

