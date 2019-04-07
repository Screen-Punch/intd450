extends Node2D

func _ready():
	pass


func _on_Player_spawned():
	$Rubble.show()
	$Timer.start(1)
	$Player.canMove = false

func _on_Timer_timeout():
	name = "Level 1-0"
	$CanvasLayer/TextTransition.setTransitionText()
	$CanvasLayer/TextTransition/TextAnimator.play("ScreenBlockerFadeIn")


func _on_TextTransition_textFadeOut():
	$CanvasLayer/TextTransition/TextAnimator.play("TextFadeOutNoFollow")

func _on_TextTransition_textFadeOutNoFollow():
	$Player.canMove = true
	name = "Level 1-15"
	$CanvasLayer/TextTransition.setTransitionText()
