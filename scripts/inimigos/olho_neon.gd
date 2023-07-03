extends KinematicBody2D

onready var target
const scn_disparo = preload("res://scenes/all_boss/boss2/tiro_boss2.tscn")

var moveSpeed : int = 60
var chaseDist : int = 400

func _ready():
	$anim.play("mov_olho")

func _physics_process(_delta):

	if target:
		var dist = target.position.distance_to(position)
	
		if dist < chaseDist:
			var vel = (target.position - position).normalized()
			move_and_slide(vel * moveSpeed)
		
		
	#TIMER DO EFEITO DE DISPARO DO OLHO
		if $Timer.get_time_left() <= 0.3:
			$anim.play("pre_tiro")

	#TIMER DO EFEITO DE DISPARO DO OLHO

		$sprite/Node2D.look_at(target.position)
		$sprite/Node2D/AnimatedSprite.rotation = -$sprite/Node2D.rotation
		$sprite/Node2D/circulo_vermelho.rotation = -$sprite/Node2D.rotation
		$sprite/Node2D/pre_tiro.rotation = -$sprite/Node2D.rotation

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"): 
		target = get_node("/root/world/player")

func _on_Area2D_body_exited(body):
	#if body.is_in_group("player"):
		#target = null
	pass
func atirar():
	var disparo = scn_disparo.instance()
	if target:
		disparo.position = position
		disparo.scale =  Vector2(0.6, 0.6)
		disparo.vel = 30
		disparo.dir = Vector2(cos($sprite/Node2D.rotation), sin($sprite/Node2D.rotation))
		get_parent().call_deferred("add_child", disparo)

	

