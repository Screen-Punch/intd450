extends Area2D

# class member variables go here, for example:
export (String, FILE, "*.tscn") var next_world
export (int) var level 
export (String) var nextLevelText
var blocked = true
var textCanAdvance = false
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
"...you bear an uncanny resemblance to him. Interesting."],
["The bittersweet stench of desperation reeks upon you... it betrays your every step.",
"How you scurry about like a witless rat..."],
["You may be able to run, and you may be able to buy yourself a moment's respite… but you will inevitably err."],
["Flee you fool..."], # 7
["...Your essence tastes so sweet."],
["What are we? Playing cat and mouse in the shadows?"],
["Your world collapses on you..."], # 10
["Turn around, you only delay the end. Perhaps I will be quick."],
["Are you not tired!? You have run so far, only approaching the same end!"],
["The end has come..."],  # 13 = Last level currently
["Run..."],
["This is a harsh fall"],
["It was only a matter of time that another wanderlusting soul would find this place...\nMy wayward whispers… snaking and burrowing deeply into unsuspecting hearts and minds…\nLike a siren's song... how sweetly they promise the countless, irresistible desires and curiosities of the mortal heart..."],
[""],
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
				textTracker += 1
				$CanvasLayer/Control/TextAnimator.play("TextTransition")
				$CanvasLayer/Control/Label.text = transitionText[textTracker]
		else:
			GameManagerNode.loadNextLevel(next_world, nextLevelText)

func _on_next_W_body_entered(body):
	if body.is_in_group("Player") and !blocked:
		body.hideTimer()
		GameManagerNode.set_level_time()
		time = GameManagerNode.get_level_time(level)
		body.vulnerable = false
		#_on_Timer_timeout() # Play Monster Noises while reading text
		$CanvasLayer/Control/AnimationPlayer.play("SceneTransition")
		$CanvasLayer/Control/TextAnimator.play("TextTransition")
	if body.is_in_group("Monster") and !blocked:
		body.playMonsterTakesStairs()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "ExitUnlocked":
		$StatueSprite.queue_free()


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
