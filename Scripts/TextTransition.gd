extends Node2D

# Declare member variables here. Examples:
var textCanAdvance = false
var transitionText
var textTracker = 0
var aboutToAdvanceLevel = false

const PLAYER_TEXT_COLOR = Color(205.0/255.0, 50.0/255.0, 50.0/255.0)
const MONSTER_TEXT_COLOR = Color(80.0/255.0, 70.0/255.0, 255.0/255.0)

export (bool) var playerDeathSequence = false

signal textFadeOut
signal textFadeOutNoFollow

var narrativeSequences = [
["Ugh… h-how far did I fall, there? I can no longer see any light from above...",
	"The forgotten treasure is nearly within your grasp...",
	"...no. Such questions are irrelevant now. I must keep going!",
	], #0 indexed. This plays when the player falls down
[""],
["..."],	# 2 (Monster first appears)
[" ...what is the meaning of this?",
	"These accursed conduits of light… I thought I had dealt with these annoyances."],
["Your mind is an open book, wanderluster. You cannot help but wonder as to the nature of this strange, forgotten place...",
	"I knew the ones who built it, in an age long past. They fancied themselves clever and crafty, and dug so deep.",
	"...for all their vaunted ingenuity, however, they nevertheless surrendered themselves to my will in the end.",],
["Desperation’s bittersweet stench reeks upon you, wanderluster. It betrays your every step, like a festering wound.",
	"Do not mistake these affordances of fleeting respite for safety, like they did. You will never escape my notice within these walls..."],
["..."], # 6
["..."],
["You are beginning to wonder if this labyrinth will ever end, aren’t you?",
	"You can feel the oppressive earth above your head, below your feet, pressing in against the walls themselves… it encompasses you, isolating you almost completely from the surface world.",
	"You struggle on two fronts, wanderluster… can you hold out long enough to find the freedom you so dearly desire?"
],
["..."],
["..."], # 10 # Decided in onReady
["..."],
["..."], # 12 
["..."], 
["..."],	# 14 Last "full level", decded in onReady
["I have come so far from home, risking it all on this dangerous adventure into lands unknown… I cannot return empty handed!",
	"My family is depending upon it...",
	"You shall be their deliverance… do not falter now.",
	"I can still hear the whispers. They beckon me forth just a little further..."],
["It was only a matter of time that another wanderlusting soul would find this place...",
	"My wayward whispers... they burrow and take root deeply within unsuspecting hearts and minds.",
	"Like the siren's song, they stir an irresistible urge within the mortal heart to seek out their deepest desires...drowning out the futile efforts of reason to intervene..."],
["..."], # 17 unused level
[""],
["The adventurer, basking in the newfound embrace of sunlight, made haste to return to civilization. Upon reaching home, the adventurer decided against sharing the details of their harrowing experience in that forgotten place - unwilling to risk provoking the curiosities of any other adventurous souls towards any independent investigating.", 
	"Instead, they returned home quietly and resigned themselves to a relatively stress-free existence.",
	"The nightmares came, no less, and many a night would be plagued with restlessness. They had ultimately triumphed against overwhelming odds, though, and took solace in this fact.","One lingering concern remained paramount in their mind, however: were there other victims the monster had neglected to mention, and where might they be now…?"],
["The adventurer began their journey but an ordinary, wanderlusting soul, guided by the call of adventure into the far-off frontier. What they found out there, however, would change them irrevocably.", 
	"The adventurer, deprived of much of their former humanity, struggled under the antagonistic embrace of the sunlight as they made their way back to civilization. Upon reaching home, the adventurer - heeding the call of a new voice - decided to share their tale with their fellow adventurers - to a certain extent, of course.",
	"The Old One - slumbering deep beneath the earth in that forgotten place - would be satiated. It was only a matter of time, and its patience was bountiful."],
]
# 0 is monster, 1 is PC
var narrativeSequencesTextColors = [[1,0,1], [0,0], [0,0], [0,0], [0,0], # 0, 1, 2, 3, 4
									[0,0,0], [0], [0,0,0], [0], [0], # 5, 6, 7, 8, 9
									[0,0,0], [0], [0, 0, 0], [0,0], [0,0,0], # 10, 11, 12, 13, 14
									[1,1,0,1], [0,0,0], [0, 0], [0, 0], [1, 1, 1, 1], [0,0,0]]	# level 15-18


var playerDiedText = [["Slowly but surely, your mortal body has found its paltry limits.",
"...and now, I will take but the first fragment of something even more valuable from you: your soul.", 
"Fragment by fragment, you will surrender all that you are...in service to my will.",
]]
var playerDiedTextColors = [[0, 0, 0]]
var textColor
var level

# Called when the node enters the scene tree for the first time.
func _ready():
	updateTransitionText()


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
		$Label.self_modulate = PLAYER_TEXT_COLOR
	else:
		$Label.self_modulate = MONSTER_TEXT_COLOR
		
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
				$Label.self_modulate = PLAYER_TEXT_COLOR
			else:
				$Label.self_modulate = MONSTER_TEXT_COLOR
	if anim_name == "ScreenBlockerFadeIn":
		$TextAnimator.play("TextTransition")
	if anim_name == "TextFadeOutNoFollow":
		emit_signal("textFadeOutNoFollow")
		
func updateTransitionText():
	if GameManagerNode.totalDeaths >= GameManagerNode.BAD_END_DEATH_THRESHOLD:
		narrativeSequences[12] = ["The seeds of doubt are blooming within you, wanderluster... ", 
			"Something within you is fundamentally… changing. You know this.",
			"Do not be afraid. You are not alone in the process..."
		]
		narrativeSequences[18] = ["The desire now lingering in your heart...embrace it. Submit to it. Comprehension will come in due time. Steel yourself, now. The surface world rushes to greet you once again..."]
	else:
		narrativeSequences[12] = ["Your heart desires nothing less than to bask in the warmth of your precious sunlight once again...",
			"One by one, these conduits of light - your one means of temporary salvation - have nearly become completely expunged.",
			"Soon, you will know naught but the all-encompassing darkness that returns to swallow this forgotten place.",
		]
		narrativeSequences[18] = ["You may have found your escape, mortal, but delude yourself not: you have been changed in ways that you will carry upon your shoulders for the rest of your days. You, or another, will return in due time… it is inevitable. And I shall be waiting."]

