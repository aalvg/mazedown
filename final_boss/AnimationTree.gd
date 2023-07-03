extends AnimationTree


func _ready():
	pass

func set_condition(condition_name, value):
	set("parameters/conditions" + condition_name, value)
	
