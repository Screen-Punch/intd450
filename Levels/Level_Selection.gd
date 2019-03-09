extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func _on_Level1_pressed():
	#get_tree().change_scene("res://Levels/Level1-2.tscn")
	var level_file = "res://Levels/Level1-2.tscn"
	get_tree().change_scene(level_file)
	
