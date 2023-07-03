extends CollisionShape2D

var motion_up

func _physics_process(delta):
	if Input.is_action_pressed("tracking_mouse"):
		#mouse pra cima
		motion_up = (utils.mouse_pos.y - position.y)
		translate(Vector2(0, motion_up)) 
