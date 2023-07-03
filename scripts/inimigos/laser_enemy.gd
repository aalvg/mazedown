extends Area2D

var max_dist = 120
var live_laser = true
onready var init_pos = global_position
var dir = Vector2() setget set_dir
var vel = -100

func _ready():
	pass

func _process(delta):
	translate(dir * vel * delta)
	if live_laser:
		if global_position.distance_to(init_pos) > max_dist:
			live_laser = false
			$sprite.hide()
			queue_free()
			
func set_dir(val):
	dir = val
	rotation = dir.angle()

func _on_laser_enemy_body_entered(other):
	if other.is_in_group("player"):
		other.armor -= 1
		utils.remote_call("camera", "shake", 3, 0.13)
		queue_free()
