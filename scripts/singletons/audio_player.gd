extends Node

var player = AudioStreamPlayer.new()
func _ready():
	return
	#yield(get_tree().create_timer(4), "timeout")
	play("music")
	
func play(name):
	player = $SFX
	player.stream = $loader_samples.get_resource(name)
	
	player.play()
	#player.connect("finished", player, "queue_free")
	remove_child(player)
	add_child(player)

