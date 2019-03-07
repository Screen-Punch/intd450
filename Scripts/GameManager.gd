extends Node2D

# class member variables go here, for example:
var deathsInLevel = 0
var totalDeaths = 0

func _ready():
	pass

func reloadLevel():
	call_deferred("_reloadLevel")
	
func _reloadLevel():
	deathsInLevel += 1
	totalDeaths += 1
	var sceneName = get_tree().get_current_scene().get_name()
	get_tree().change_scene("res://Levels/" + sceneName + ".tscn")

func loadNextLevel(sceneName, levelName):
	call_deferred("_loadNextLevel", sceneName, levelName)

func _loadNextLevel(sceneName, levelName):
	deathsInLevel = 0
	if "Level" in get_tree().get_current_scene().get_name():
		$CanvasLayer/Label.text = levelName
		$AnimationPlayer.play("LevelStart")
	get_tree().change_scene(sceneName)