extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta): #for testing
	if Input.is_action_pressed("ui_up"):
		get_tree().change_scene("res://Levels/level_book.tscn")
	pass


func _on_NewGameButton_pressed():
	get_tree().change_scene("res://Levels/Level1-1.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()
