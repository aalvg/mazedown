extends Sprite

export var direcao = Vector2(0,1)
export var velocidade = 50

func _ready():
	$anim.play("sprite")

func _process(delta):
	translate(direcao * velocidade * delta)

