extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var timer = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
func _process(delta):
	timer += delta
	if timer > 3.0:
		get_tree().change_scene("res://Levels/Level 1-15.tscn")