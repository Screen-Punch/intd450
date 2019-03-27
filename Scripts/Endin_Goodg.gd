extends Area2D

# class member variables go here, for example:
export (String, FILE, "*.tscn") var next_world
export (int) var level 
export (String) var nextLevelText
var blocked = true
var textCanAdvance = false
var aboutToAdvanceLevel = false
var time = 0
var transitionText
var textTracker = 0
var narrativeSequences = [
["It was only a matter of time that another wanderlusting soul would find this place..."], #0 indexed
["My wayward whispers... snaking and burrowing deeply into unsuspecting hearts and minds…",
	"Like a siren's song... how sweetly they promise the countless, irresistible desires and curiosities of the mortal heart..."],
[""],	# 2 (Monster first appears)
["I-..."],
["My solitary slumber was left unabated by guests for countless ages since the last intrusion...",
	"...you bear an uncanny resemblance to him.", "Interesting."],
["The bittersweet stench of desperation reeks upon you... it betrays your every step.",
	"How you scurry about like a witless rat..."],
["You may be able to run, and you may be able to buy yourself a moment's respite… but you will inevitably err."],
["..."], # 7
["..."],
["..."],
["..."], # 10
["You must realize by now that it is futile to hide just how fleeting and fragile that brave front of yours really is..."],
["You can feel the oppressive earth above our heads, isolating us completely from the surface world...",

"One by one, these conduits of light have nearly become completely expunged.",

"Soon, you will know naught but the all-encompassing darkness that returns to swallow this forgotten place."],
["You delude yourself, mortal.",

"You cannot escape the inevitable!"],  # 13 = Last level currently
[""],
["Ugh, my head", "W-where am I...?"],
["It was only a matter of time that another wanderlusting soul would find this place..."],
["My wayward whispers… snaking and burrowing deeply into unsuspecting hearts and minds…","Like a siren's song... how sweetly they promise the countless, irresistible desires and curiosities of the mortal heart..."],
["I-I don’t understand what just happened, but…", "That door… what would’ve happened if that horrible monstrosity had gotten ahold of me just one more time?"]
]

func _ready():
	#level = 1
	GameManagerNode.set_current_level(level)
	if GameManagerNode.get_level_selection() == true:
		next_world = "res://Levels/Main Menu.tscn"
	# Called when the node is added to the scene for the first time.
	# Initialization here
	if !next_world:
		next_world = "res://Levels/Main Menu.tscn"
	setTransitionText()
	if !nextLevelText:
		nextLevelText = "Level: ???"


func _process(delta):
	pass

func _input(event):
	if event is InputEventKey and textCanAdvance:
		if event.pressed:
			textCanAdvance = false
			if textTracker < transitionText.size()-1:
				$CanvasLayer/Control/TextAnimator.play("TextFadeOut")
			else:
				aboutToAdvanceLevel = true
				$CanvasLayer/Control/TextAnimator.play("TextFadeOut")


func _on_next_W_body_entered(body):
	if body.is_in_group("Player") and !blocked:
		body.hideTimer()
		GameManagerNode.set_level_time()
		time = GameManagerNode.get_level_time(level)
		body.vulnerable = false
		$foot_step2.play(0)
		#_on_Timer_timeout() # Play Monster Noises while reading text
		$CanvasLayer/Control/AnimationPlayer.play("SceneTransition")
		$CanvasLayer/Control/TextAnimator.play("TextTransition")
	if body.is_in_group("Monster") and !blocked:
		body.playMonsterTakesStairs()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "ExitUnlocked":
		$StatueSprite.queue_free()
		$Light2D.show()


func revealExit():
	blocked = false
	$CanvasLayer/Control/AnimationPlayer.play("ExitUnlocked")

func setTransitionText():
	var root = get_tree().root
	var level
	for child in root.get_children():
		if "Level" in child.name:
			level = child.name.split("-")[1]

	transitionText = narrativeSequences[int(level)]
	if transitionText.size() > 0:
		$CanvasLayer/Control/Label.text = transitionText[textTracker]

func _on_TextAnimator_animation_finished(anim_name):
	if anim_name == "TextTransition":
		textCanAdvance = true
	if anim_name == "TextFadeOut":
		if aboutToAdvanceLevel:
			GameManagerNode.loadNextLevel(next_world, nextLevelText)
		else:
			textTracker += 1
			$CanvasLayer/Control/TextAnimator.play("TextTransition")
			$CanvasLayer/Control/Label.text = transitionText[textTracker]



func _on_Ending_Good_body_entered(body):
	if body.name == "Monster" and !blocked:
		GameManagerNode.set_level_time()
		time = GameManagerNode.get_level_time(level)
		#_on_Timer_timeout() # Play Monster Noises while reading text
		$CanvasLayer/Control/AnimationPlayer.play("SceneTransition")
		$CanvasLayer/Control/TextAnimator.play("TextTransition")