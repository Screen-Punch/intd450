extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


# Resumes game
func _on_ResumeButton_pressed():
	hide()
	get_tree().paused = false


func _on_ExitButton_pressed():
	$ExitButton/ExitConfirmation.show()


func _on_YesExit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Levels/Main Menu.tscn")


func _on_NoExit_pressed():
	$ExitButton/ExitConfirmation.hide()