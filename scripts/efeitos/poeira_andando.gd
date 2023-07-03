extends Position2D

func _ready():
	$anim.play("correndo")

func _on_anim_animation_finished(_anim_name):
	queue_free()
