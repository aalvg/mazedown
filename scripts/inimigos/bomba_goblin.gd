extends RigidBody2D

export var vel = 100
var dir = Vector2(0, -1)
const scn_explodir = preload("res://scenes/efeitos/efeitos_explosivos/circulo_expl_vermelho.tscn")

func _ready():
	
	pass
	
func _process(_delta):
		#translate(vel * dir * delta)
	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_tiro_boss1_body_entered(body):
		if body.is_in_group("player"):
			vel = 0
			body.armor -= 1
			#utils.remote_call("camera", "shake", 3, 0.13)
			$Sprite.visible = false
			yield(get_tree().create_timer(0.8), "timeout")
			explodir()
			queue_free()


func _on_Timer_timeout():
	explodir()
	queue_free()

func explodir():
	var explosao =  scn_explodir.instance()
	explosao.position = global_position
	explosao.scale = Vector2(0.3,0.3)
	utils.main_node.add_child(explosao)
	
func atingir():
	$sensor/col.disabled = false
	pass
	
func anim():
	$anim.play("bomba")

func _on_sensor_body_entered(body):
	if body.is_in_group("player"):
		body.armor -= 1
