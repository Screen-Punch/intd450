extends Node2D

# Declare member variables here. Examples:
var textCanAdvance = false
var transitionText
var textTracker = 0
var aboutToAdvanceLevel = false

export (bool) var playerDeathSequence = false

signal textFadeOut

var narrativeSequences = [
["It was only a matter of time that another wanderlusting soul would find this place..."], #0 indexed
["My wayward whispers, how they snake and burrow deeply into unsuspecting hearts and minds.",
	"Like a siren's song, they sweetly promise the countless, irresistible desires and curiosities of the mortal heart."],
[""],	# 2 (Monster first appears)
["Y-..."],
["My solitary slumber was left unabated for countless ages since others stepped foot in this place...",
	"...you bear an uncanny resemblance to one of them. How interesting."],
["The bittersweet stench of desperation reeks upon you. It betrays your every step.",
	"How you scurry about like a witless rat..."],
["You may be able to run, and you may be able to buy yourself a moment's respite... but you will inevitably err."],
["..."], # 7
["..."],
["..."],
["..."], # 10
["You must realize by now that it is futile to hide just how fleeting and fragile that brave front of yours really is."],
["You can feel the oppressive earth above our heads, isolating us completely from the surface world.",

"One by one, these conduits of light have nearly become completely expunged.",

"Soon, you will know naught but the all-encompassing darkness that returns to swallow this forgotten place."],
["You delude yourself, mortal.",

"You cannot escape the inevitable!"],  # 13 = Last level currently
[""],
["Ugh… h-how far did I fall, there?", "I-I must keep going... my prize is so close now, I can feel it!"],
["It was only a matter of time that another wanderlusting soul would find this place..."],
["My wayward whispers… snaking and burrowing deeply into unsuspecting hearts and minds…","Like a siren's song... how sweetly they promise the countless, irresistible desires and curiosities of the mortal heart..."],
["It must have been so tiring, resisting what you knew deep within to be inevitable…", "Retire all that you once were, mortal, and embrace your new existence… forevermore."]
]
# 0 is monster, 1 is PC
var narrativeSequencesTextColors = [[0], [0,0], [0], [0], [0,0],
									[0,0], [0], [0], [0], [0],
									[0], [0], [0, 0, 0], [0], [0],
									[1,1], [0], [0, 0], [0, 0]]	# level 15-18


var playerDiedText = [["Slowly but surely, your mortal body has found its paltry limits.",
"...and now, I will take but the first fragment of something even more valuable - your soul - from you.", 
"Fragment by fragment, you will surrender all that you are...in service to my will.",
"I-I will never serve you, monster!",
"Your foul trickery will never be rewarded!"
]]
var playerDiedTextColors = [[0, 0, 0, 1, 1]]
var textColor
var level

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if event is InputEventKey and textCanAdvance:
		if event.pressed:
			textCanAdvance = false
			$TextAnimator.play("TextFadeOut")
			if textTracker >= transitionText.size()-1:
				aboutToAdvanceLevel = true


func setTransitionText(playerDeath = false):
	if !playerDeath:
		var root = get_tree().root
		level = 1
		for child in root.get_children():
			if "Level" in child.name:
				level = child.name.split("-")[1]
	
		transitionText = narrativeSequences[int(level)]
		textColor = narrativeSequencesTextColors
	else:
		level = 0
		transitionText = playerDiedText[level]
		textColor = playerDiedTextColors
	if transitionText.size() > 0:
		$Label.text = transitionText[textTracker]
	if textColor[int(level)][int(textTracker)] == 1:	# Player text
		$Label.self_modulate = Color(1, 0, 0)
	else:
		$Label.self_modulate = Color(0, 0, 1)

func _on_TextAnimator_animation_finished(anim_name):
	if anim_name == "TextTransition":
		textCanAdvance = true
	if anim_name == "TextFadeOut":
		if aboutToAdvanceLevel:
			emit_signal("textFadeOut")
		else:
			textTracker += 1
			$TextAnimator.play("TextTransition")
			$Label.text = transitionText[textTracker]
			if textColor[int(level)][int(textTracker)] == 1:	# Player text
				$Label.self_modulate = Color(1, 0, 0)
			else:
				$Label.self_modulate = Color(0, 0, 1)
	if anim_name == "ScreenBlockerFadeIn":
		$TextAnimator.play("TextTransition")