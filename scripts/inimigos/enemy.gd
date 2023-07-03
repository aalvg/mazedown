extends Area2D

export var armor = 1 setget set_armor
export var score_value = 1
export var velocity = Vector2()

const scn_explosion = preload("res://scenes/efeitos/explosion.tscn")

func _ready():
	add_to_group("enemy")
	connect("area_entered", self, "_on_area_entered")

func _process(delta):
	translate(velocity * delta)
	if position.y-16 >= utils.view_size.y:
		queue_free()

func _on_area_entered(other):
	if other.is_in_group("player"):
		other.armor -= 1
		create_explosion()
		queue_free()

func set_armor(new_value):
	if is_queued_for_deletion(): return
	if new_value < armor: 
		audio_player.play("hit_enemy")
		armor = new_value
	
	if armor <= 0:
		utils.search_node("tex_score").score += score_value
		create_explosion()
		queue_free()

func create_explosion():
	var explosion = scn_explosion.instance()
	explosion.position = self.position
	utils.main_node.add_child(explosion)
