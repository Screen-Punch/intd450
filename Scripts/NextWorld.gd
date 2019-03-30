extends Area2D

# class member variables go here, for example:
export (String, FILE, "*.tscn") var next_world
export (int) var level 
export (String) var nextLevelText
export (bool) var blocked = true


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
	if !nextLevelText:
		nextLevelText = ""
	if !blocked:
		revealExit()

func _process(delta):
	pass


func _on_next_W_body_entered(body):
	if body.is_in_group("Player") and !blocked:
		$CanvasLayer/TextTransition.setTransitionText()
		if GameManagerNode.deathsInLevel == 0:
			GameManagerNode.totalDeaths -= 3
			if GameManagerNode.totalDeaths < 0:
				GameManagerNode.totalDeaths = 0
		body.hideTimer()
		GameManagerNode.set_level_time()
		time = GameManagerNode.get_level_time(level)
		body.vulnerable = false
		$foot_step2.play(0)
		#_on_Timer_timeout() # Play Monster Noises while reading text
		$CanvasLayer/TextTransition/TextAnimator.play("ScreenBlockerFadeIn")
	if body.is_in_group("Monster") and !blocked:
		body.playMonsterTakesStairs()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "ExitUnlocked":
		$Light2D.show()


func revealExit():
	blocked = false
	$AnimationPlayer.play("ExitUnlocked")


func _on_TextTransition_textFadeOut():
	GameManagerNode.loadNextLevel(next_world, nextLevelText)
