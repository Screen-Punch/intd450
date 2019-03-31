extends VideoPlayer

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	pass


func _input(event):
	if event is InputEventKey:
		if event.pressed:
			get_tree().change_scene("res://Levels/Main Menu.tscn")


func _on_VideoPlayer_finished():
	get_tree().change_scene("res://Levels/Main Menu.tscn")