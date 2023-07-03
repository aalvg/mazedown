extends RigidBody2D

export var bouncing = .1


func _ready():
	#randomize()
	#bounce = bouncing
	#gravity_scale = 0
	#linear_damp = 1
	#var dir = randf() * (PI * 2)
	#apply_impulse(Vector2(), Vector2(cos(dir), sin(dir)) * 70)
	$Poly.scale = get_parent().scale
	
