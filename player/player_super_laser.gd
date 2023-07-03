# LaserGun that fires based on user's input

extends super_laser

export var fire_action := "fire"
export var fire_up := "ui_up"


func _unhandled_input(event: InputEvent) -> void:
	if event.is_echo():
		return
	if event.is_action(fire_action):
		self.is_firing = event.is_pressed()

	if event.is_action(fire_up):
		self.is_firing = event.is_pressed()
		

