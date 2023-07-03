extends KinematicBody2D

var pode_girar = false
export var vel_giro = 50
const scn_disparo = preload("res://scenes/inimigos/inimigos_obj/tiro_torreta.tscn")

#skins
export(int , "normal", "gelo") var sprite = 0 setget set_sprite
var modelo_sprite = [
	"res://sprites/inimigos/torreta/torreta1.png", #0
	"res://sprites/inimigos/torreta/torreta_neve/torreta1.png", #1
]
#skins
func _draw():
	$Sprite.texture = load(modelo_sprite[sprite])
	
func set_sprite(val):
	sprite = val
	if Engine.editor_hint:
		update()
		
func _physics_process(delta):
	if Engine.editor_hint:
		return
	if pode_girar:
		rotation_degrees += vel_giro * delta
		$anim.play("normal")
		if rotation_degrees >= 360 or rotation_degrees <= -360:
			rotation_degrees = 0
			pode_girar = false
			$anim.play("carregar")
			
func _on_Timer_timeout():
	pode_girar = true

func disparo():
	for i in 3:
		var disparar = scn_disparo.instance()
		disparar.global_position = $pos2D.global_position
		match i:
			0:
				#pra baixo
				if scale.x <= -0:
					disparar.dir = Vector2(-1,0.3)
					disparar.scale.x = -0.3
					disparar.rotation_degrees = -10

				else:
					disparar.dir = Vector2(1,-0.3)
					disparar.scale = Vector2(0.3,0.3)
			1:
				#do meio
				if scale.x <= -0:
					disparar.dir = Vector2(-1,0)
					disparar.scale.x = -0.3
				else:
					disparar.dir = Vector2(1,0)
					disparar.scale = Vector2(0.3,0.3)
			2:
				#pra cima
				if scale.x <= -0:
					disparar.dir = Vector2(-1,-0.3)
					disparar.rotation_degrees = -175
					#disparar.scale.x = -0.3
				else:
					disparar.dir = Vector2(1,0.3)
					disparar.scale = Vector2(0.3,0.3)
					disparar.rotation_degrees = 10

					
		get_parent().add_child(disparar)
