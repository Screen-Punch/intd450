extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$next_W.revealExit()
	$Player/Camera2D.zoomfactor = 1.0
	$Player.hideTimer()
	if GameManagerNode.totalDeaths >= GameManagerNode.BAD_END_DEATH_THRESHOLD:
		name = "Level 1-20"
		$AnimationPlayer.play("Bad_Ending")
	else:
		$AnimationPlayer.play("Good_Ending)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass