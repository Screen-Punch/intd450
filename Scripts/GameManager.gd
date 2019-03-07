extends Node2D

# class member variables go here, for example:
var deathsInLevel = 0
var totalDeaths = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func reloadLevel():
	deathsInLevel += 1
	totalDeaths += 1
	var sceneName = get_tree().get_current_scene().get_name()
	get_tree().change_scene("res://Levels/" + sceneName + ".tscn")

func loadNextLevel(sceneName):
	deathsInLevel = 0
	get_tree().change_scene(sceneName)