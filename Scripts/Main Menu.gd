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
	play_click_sound()
	get_tree().change_scene("res://Levels/Level_Intro_Scene.tscn")


func _on_ExitButton_pressed():
	play_click_sound()
	get_tree().quit()


func _on_CreditsButton_pressed():
	play_click_sound()
	$Credits.show()
	$AnimationPlayer/Crystal.hide()
	$Monster.hide()
	$DefaultMenu.hide()


func _on_CreditsReturnButton_pressed():
	play_click_sound()
	$Credits.hide()
	$AnimationPlayer/Crystal.show()
	$Monster.show()
	$DefaultMenu.show()

func play_click_sound():
	$click.play(0)
	print("1111")