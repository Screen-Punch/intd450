extends Node2D

func _ready():
	$next_W.revealExit()

func _process(delta):
	
	#var v = Vector2()
	$fog.position.x += 0.1
	$fog.position.y += 0.1