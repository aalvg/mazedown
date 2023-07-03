extends Area2D

export var vel = 150
var dir = Vector2(0, -1)

func _ready():
	add_to_group("enemy")
	$AnimationPlayer.play("tiro")
	
func _process(delta):
		translate(vel * dir * delta)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_tiro_boss1_body_entered(body):
		if body.is_in_group("player"):
			#$Sprite.visible = false
			$AnimationPlayer.play("explodir")
			vel = 0
			body.armor -= 1
			utils.remote_call("camera", "shake", 3, 0.13)
			yield(get_tree().create_timer(0.8), "timeout")
			queue_free()

func _on_Timer_timeout():
	$AnimationPlayer.play("explodir")
