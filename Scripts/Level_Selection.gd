extends Control

var goalTime = [-1, 21, 5.5, 9, 14.5, 12.5, 11.5, 7.5, 13, 5, 7, 12, 14.5, 20, 10, 10, 10, 10,]

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var i = 0
	for child in get_children():
		if "Level" in child.name:
			i += 1
			#disconnect("mouse_entered", self, "_on_Level_mouse_entered")
			#connect("mouse_entered", self, "_on_Level_mouse_entered", [i])
	pass

func _on_Level_mouse_entered(level):
	var bestTime = GameManagerNode.level_time[level]
	if bestTime == -1:
		bestTime = "Not Played"
	$Panel/BestTime.text = "Best Time:" + str(bestTime)
	$Panel/GoalTime.text = "Goal Time:" + str(goalTime[level]) + ".0"
	

func convertTimeToMMSS(value):
	pass