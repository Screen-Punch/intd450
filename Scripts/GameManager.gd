extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func reloadLevel():
	var sceneName = get_tree().get_current_scene().get_name()
	get_tree().change_scene("res://Levels/" + sceneName + ".tscn")