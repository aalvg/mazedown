extends KinematicBody2D

const scn_disparo = preload("res://scenes/inimigos/80s/tiro_nave.tscn")

var moveSpeed : int = 60
var velocity = Vector2(0,50)
var trocar_dir
var tempo_movimento = 0

func _process(delta):
	tempo_movimento += 1
	if tempo_movimento < 250:
		velocity.y = abs(velocity.y)
	elif tempo_movimento > 250:
		velocity.y = -abs(velocity.y)
	if tempo_movimento >= 500:
		tempo_movimento = 0
	
func _physics_process(_delta):
	translate(velocity * _delta)

#	#TIMER DO EFEITO DE DISPARO DO OLHO
	if $Timer.get_time_left() <= 0.3:
		$atirando.show()
		$anim.play("tiro")
		$sprite.hide()
	else:
		$sprite.show()
		$atirando.hide()


func atirar():
	var disparo = scn_disparo.instance()
	disparo.position = $pos.global_position
	disparo.scale =  Vector2(0.8, 0.8)
	disparo.vel = 70
	disparo.dir = Vector2(-1,0) if scale.x == -1 else Vector2(1,0) #Vector2(cos($sprite/Node2D.rotation), sin($sprite/Node2D.rotation))
	get_parent().call_deferred("add_child", disparo)
