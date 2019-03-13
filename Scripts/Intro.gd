extends VideoPlayer

# class member variables go here, for example:
var timer = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	timer += 1
	if timer > 300:
		get_tree().change_scene("res://Levels/Main Menu.tscn")
