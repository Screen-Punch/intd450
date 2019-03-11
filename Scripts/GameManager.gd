extends Node2D

# class member variables go here, for example:
var deathsInLevel = 0
var totalDeaths = 0

var level_selection_mode = false
var level_time = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
var current_time
var current_level

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
	
func set_level_selection_to_true():
	level_selection_mode = true
	
func get_level_selection():
	return level_selection_mode
	
func get_level_time(level):
	return level_time[level]

func foo():
	print($RichTextLabel.get_time())

func set_level_time():
	if level_time[current_level]==-1 or current_time<level_time[current_level]:
		level_time[current_level] = current_time
	print(level_time)
	
func set_current_time(time):
	current_time = time

func get_current_time():
	return current_time
	
func set_current_level(level):
	current_level = level

