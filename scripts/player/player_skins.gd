extends ControleTiros
class_name PlayerSkins

#skins
export(int , "normal", "gelo", "dino", "lenhador", "mumia") var sprite = 0 setget set_sprite
var modelo_sprite = [
	"res://sprites/player/Player-export.png", #0
	"res://sprites/player/Player_ice.png", #1
	"res://sprites/player/dino_player.png", #2
	"res://sprites/player/lenhador_player.png", #3
	"res://sprites/player/Player_mumia.png"#4
]
#skins

func _draw():
	$rotacao/sprite.texture = load(modelo_sprite[sprite])
	
func set_sprite(val):
	sprite = val
	if Engine.editor_hint:
		update()
