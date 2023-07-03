extends Area2D

var vel = 100
var dir = Vector2(0,1)

const pre_fragmentos = preload("res://scenes/all_boss/boss1/box_fragmentos.tscn")

func _ready():
	add_to_group("enemy")
	
func _physics_process(delta):
		translate(vel * dir * delta)

func _on_tiro_boss1_body_entered(body):
		if body.is_in_group("player"):
			vel = 0
			body.armor -= 1
			#utils.remote_call("camera", "shake", 3, 0.13)
			$Sprite.visible = false
			efeitos_destruicao()
			yield(get_tree().create_timer(0.8), "timeout")
			queue_free()
		
func efeitos_destruicao():
	var fragmentos = pre_fragmentos.instance()
	fragmentos.position = $Sprite.position
	fragmentos.scale = scale
	add_child(fragmentos)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

