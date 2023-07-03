tool
extends KinematicBody2D

export(int , "branco", "preto") var sprite = 0 setget set_sprite
var modelo_sprite = [
	"res://sprites/custom.png", #0
	"res://sprites/custom_blac.png", #1
]

func _draw():
	$sprite.texture = load(modelo_sprite[sprite])

func _physics_process(_delta):
	if Engine.editor_hint:
		return

func set_sprite(val):
	sprite = val
	if Engine.editor_hint:
		update()

func _on_se_player_pisar_body_entered(body):
	if body.is_in_group("player"):
		yield(get_tree().create_timer(2), "timeout")
		$sprite.visible = false
		$spt.visible = true
		$spt.playing = true
		yield(get_tree().create_timer(1), "timeout")
		queue_free()
