extends Camera2D

var _intensidade
var rotacao_angulo = 0

func _ready():
	set_process(false)
	add_to_group("camera")
	
func _process(_delta):
	rotacao_angulo += PI / 3
	offset = Vector2(sin(rotacao_angulo), cos(rotacao_angulo) * _intensidade)
	
func shake(_intensidade, _duracao):
	set_process(true)
	self._intensidade = _intensidade
	get_tree().create_timer(_duracao).connect("timeout", self, "on_timeout")
	
func on_timeout():
	set_process(false)

