extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$next_W.revealExit()
	
	if name == "Level 1-17":
		BGMPlayer.stream = load("res://Sounds/BGM/Halo Effect.wav")
		BGMPlayer.play(0)
		GameManagerNode.BGMAudioName = "res://Sounds/BGM/Halo Effect.wav"


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
