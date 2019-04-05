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

var narrativeSequences = [
["It was only a matter of time that another wanderlusting soul would find this place..."], #0 indexed
["My wayward whispers, how they snake and burrow deeply into unsuspecting hearts and minds.",
	"Like a siren's song, they sweetly promise the countless, irresistible desires and curiosities of the mortal heart."],
["..."],	# 2 (Monster first appears)
[" ...what is the meaning of this?",
	"These accursed conduits of light… I thought I had dealt with these annoyances."],
["Desperation’s bittersweet stench reeks upon you, wanderluster. It betrays your every step, like a festering wound.",
	"Do not mistake these affordances of fleeting respite for safety. You will never escape my notice within these walls..."],
["Your mind is an open book, wanderluster. You cannot help but wonder as to the nature of this strange, forgotten place...",
	"I knew the ones who built it, in an age long past. They fancied themselves clever and crafty, and dug so deep.",
	"...for all their vaunted ingenuity, however, they nevertheless surrendered themselves to my will in the end.",],
["..."], # 6
["You are beginning to wonder if this labyrinth will ever end, aren’t you?",
	"You can feel the oppressive earth above your head, below your feet, pressing in against the walls themselves… it encompasses you, isolating you almost completely from the surface world.",
	"You struggle on two fronts, wanderluster… can you hold out long enough to find the freedom you so dearly desire?"
],
["..."],
["..."],
["..."], # 10 # Decided in onReady
["You must realize by now that it is futile to hide just how fleeting and fragile that brave front of yours really is."],
["..."], # 12 
["..."], 
["..."],	# 14 Last "full level", decded in onReady
["Ugh… h-how far did I fall, there? I can no longer see any light from above...",
	"The forgotten treasure is nearly within your grasp… do not falter now.",
	"...no. I cannot worry about such things now. I must keep going.",
	"I have come so far from home, risking it all on this dangerous adventure into lands unknown... I cannot return empty handed!",
	"You need but overcome only one final obstacle...",
	"I can still hear the whispers. They beckon me forth just a little further..."],
["It was only a matter of time that another wanderlusting soul would find this place...",
	"My wayward whispers… snaking and burrowing deeply into unsuspecting hearts and minds…",
	"Like a siren's song... how sweetly they promise the countless, irresistible desires and curiosities of the mortal heart..."],
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
var narrativeSequencesTextColors = [[0], [0,0], [0,0], [0,0], [0,0], # 0, 1, 2, 3, 4
									[0,0,0], [0], [0,0,0], [0], [0], # 5, 6, 7, 8, 9
									[0,0,0], [0], [0, 0, 0], [0,0], [0,0,0], # 10, 11, 12, 13, 14
									[1,0,1,1,0,1], [0,0,0], [0, 0], [0, 0], [1, 1, 1, 1], [0,0,0]]	# level 15-18


var playerDiedText = [["Slowly but surely, your mortal body has found its paltry limits.",
"...and now, I will take but the first fragment of something even more valuable - your soul - from you.", 
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
			#print(int(level),":",int(textTracker),"dw")
			if textColor[int(level)][int(textTracker)] == 1:	# Player text
				$Label.self_modulate = PLAYER_TEXT_COLOR
			else:
				$Label.self_modulate = MONSTER_TEXT_COLOR
	if anim_name == "ScreenBlockerFadeIn":
		$TextAnimator.play("TextTransition")
		
func updateTransitionText():
	if GameManagerNode.totalDeaths >= GameManagerNode.BAD_END_DEATH_THRESHOLD:
		narrativeSequences[10] = ["The seeds of doubt are blooming within you, wanderluster... ", 
			"Something within you is fundamentally… changing. You know this.",
			"Do not be afraid. You are not alone in the process..."
		]
	else:
		narrativeSequences[10] = ["Your heart desires nothing less than to bask in the warmth of your precious sunlight once again...",
			"One by one, these conduits of light - your one means of temporary salvation - have nearly become completely expunged.",
			"Soon, you will know naught but the all-encompassing darkness that returns to swallow this forgotten place.",
		]



