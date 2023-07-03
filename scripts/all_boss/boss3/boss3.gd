extends KinematicBody2D

var life = 100 setget set_life
onready var init_life = life
onready var anim := $anim
onready var player = get_node("/root/world/player")

var init_attack = false
var dist : int = 100
var dist_balance : int = 90
var dist_attack : int = 60
var next_anim = "sleeping"
var current_anim = ""

const scn_shot = preload("res://scenes/all_boss/boss3/shot_boss3.tscn")

func _ready():
	add_to_group("enemy")
	
func _physics_process(_delta):
	animation()
	if player:
		var dist_player = position.distance_to(player.position)
		if dist_player < dist:
			next_anim = "idle"
			init_attack = false
		if dist_player < dist_balance:
			next_anim = "balance"
			init_attack = false
		if dist_player < dist_attack:
			next_anim = "attack"
			init_attack = true
			$spawner_cube.spawnar = true
			$bullets.play("recue")
		if next_anim == "balance" or next_anim == "idle":
			$bullets.play("bullet")
			
			
			

func set_life(new_value):
	if is_queued_for_deletion(): return
	if new_value < life:
		life = new_value
	if life <= 0:
		queue_free()
		
func animation():
	if next_anim != current_anim:
		current_anim = next_anim
	anim.play(next_anim)
	
func create_shot():
	randomize()
	var shot = scn_shot.instance()
	var array = [$esq, $dir,]
	var escolha = array[randi()%array.size()]
	#var shot_pos = escolha.position
	if init_attack:
		shot.position = escolha.position
		shot.dir.y = -1
		shot.rotation_degrees = 180
		add_child(shot)

func _on_shot_timer_timeout():
	create_shot()


