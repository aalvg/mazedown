extends Area2D

var vel = 100
export var dir = Vector2()
const scn_explosion = preload("res://scenes/efeitos/efeitos_explosivos/circulo_explosivo.tscn")

func _ready():
	add_to_group("enemy")

func _process(delta):
	translate(vel * dir * delta)

func _on_tiro_abelha_body_entered(body):
	create_explosion()
	queue_free()
	if body.is_in_group("player"):
		vel = 0
		body.armor -= 1
		$Sprite.visible = false
		create_explosion()
		queue_free()
		
func create_explosion():
	var explosion = scn_explosion.instance()
	explosion.position = self.position
	get_parent().add_child(explosion)
