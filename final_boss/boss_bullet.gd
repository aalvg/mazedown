extends Area2D

var max_dist = 170
var live_laser = true
onready var init_pos = global_position
var dir = Vector2(0,1)
var vel = -200

func _ready():
	pass
	
func _process(delta):
	translate(dir * vel * delta)
	if live_laser:
		if global_position.distance_to(init_pos) > max_dist:
			live_laser = false
			#$sprite.hide()
			queue_free()


func _on_laser_ship_body_entered(body):
	queue_free()

func _on_laser_ship_enemy_entered(body):
	if body.is_in_group("ship"):    
		body.armor -= 1
		utils.remote_call("camera", "shake", 1, 0.13)
		queue_free()
