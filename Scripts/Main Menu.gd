extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	GameManagerNode.level_selection_mode = false
	$AnimationPlayer.play("MainMenuAnimation")
	$Monster/AnimationPlayer.play("Movement")

func _on_NewGameButton_pressed():
	get_tree().change_scene("res://Levels/Level1-2.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()


func _on_CreditsButton_pressed():
	$Credits.show()
	$BouncingBox.hide()
	$DefaultMenu.hide()


func _on_CreditsReturnButton_pressed():
	$Credits.hide()
	$BouncingBox.show()
	$DefaultMenu.show()

