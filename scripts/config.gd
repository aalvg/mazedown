extends Node2D

func _ready():
	$hud/scene_transition/anim.play("abre")
	yield(get_tree().create_timer(0.350), "timeout")
	$hud/scene_transition.hide()
	$Control/conteiner2/Musica.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Musica"))
	$Control/conteiner3/SFX.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))
	$Control/conteiner4/Master.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	
func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Musica"), value)
func _on_SFX_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
func _on_Master_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
