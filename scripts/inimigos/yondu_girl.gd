extends KinematicBody2D

const scn_flecha = preload("res://scenes/inimigos/flecha_yaka.tscn")
var flecha = scn_flecha.instance()
onready var target
#onready var flecha_yaka = get_node("/root/world/flecha_yaka")

var moveSpeed : int = 90
var chaseDist : int = 400
var tempo_para_flecha = 0

func _ready():
	$idle_sprite.show()
	$sprite.hide()
	add_to_group("yondu")

func _physics_process(_delta):
	gerenciar_sprites()
	if target:
		var dist = target.position.distance_to(position)
		if dist < chaseDist:
			var vel = (target.position - position).normalized()
			move_and_slide(vel * moveSpeed)
		
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"): 
		target = get_node("/root/world/player")

func _on_Area2D_body_exited(body):
	pass

func atirar():
	if target:
		flecha.position = $Position2D.global_position
		get_parent().add_child(flecha)
		$anim.play("abrir_portal")
		flecha.nao_tem_colisor()
		yield(get_tree().create_timer(0.800), "timeout")
		flecha.tem_colisor()
		
func gerenciar_sprites():
	if flecha.assobio == true:
		$idle_sprite.hide()
		$sprite.show()
	elif flecha.assobio == false:
		$idle_sprite.show()
		$sprite.hide()



