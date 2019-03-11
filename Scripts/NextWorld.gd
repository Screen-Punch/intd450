extends Area2D

# class member variables go here, for example:
export (String, FILE, "*.tscn") var next_world
export (int) var level 
export (String) var transitionText
export (String) var nextLevelText
var blocked = true
var textCanAdvance = false
var time = 0

func _ready():
	#level = 1
	GameManagerNode.set_current_level(level)
	if GameManagerNode.get_level_selection() == true:
		next_world = "res://Levels/Main Menu.tscn"
	# Called when the node is added to the scene for the first time.
	# Initialization here
	if !next_world:
		next_world = "res://Levels/Main Menu.tscn"
	if !transitionText:
		transitionText = "What is that sound..?"+str(time)
	if !nextLevelText:
		nextLevelText = "Level: ???"
	$CanvasLayer/Label.text = transitionText


func _process(delta):
	pass

func _input(event):
	if event is InputEventKey and textCanAdvance:
		if event.pressed:
			GameManagerNode.loadNextLevel(next_world, nextLevelText)

func _on_next_W_body_entered(body):
	if body.is_in_group("Player") and !blocked:
		GameManagerNode.set_level_time()
		time = GameManagerNode.get_level_time(level)
		body.vulnerable = false
		$CanvasLayer/AnimationPlayer.play("SceneTransition")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "SceneTransition":
		textCanAdvance = true


func revealExit():
	blocked = false
	$CanvasLayer/AnimationPlayer.play("ExitUnlocked")
	