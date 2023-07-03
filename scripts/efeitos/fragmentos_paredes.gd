extends RigidBody2D

export var bouncing = .1

export(int , "madeira", "preto", "gelo", "brinquedo", "neon") var sprite = 0 setget set_sprite
var modelo_sprite = [
	"res://sprites/inimigos/quebravel_chocolate.png",
	"res://sprites/inimigos/parede_quebravel_black.png",
	"res://sprites/inimigos/parede_de_gelo.png",
	"res://sprites/inimigos/lego_fragmento.png",
	"res://sprites/inimigos/parede_neon.png"
]



func _ready():
	randomize()
	bounce = bouncing
	#gravity_scale = 0
	linear_damp = 1
	var dir = randf() * (PI * 2)
	apply_impulse(Vector2(), Vector2(cos(dir), sin(dir)) * 70)
	$Poly.scale = get_parent().scale
	
	
func _draw():
	$Poly.texture = load(modelo_sprite[sprite])

func set_sprite(val):
	sprite = val
	if Engine.editor_hint:
		update()
	
	
func _process(_delta):
	if Engine.editor_hint:
		return
	
	
