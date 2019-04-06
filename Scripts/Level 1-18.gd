extends Node2D

# class member variables go here, for example:
# var a

var timer

func _ready():
	$CanvasLayer/TextTransition.setTransitionText()

func _process(delta):
	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.hide()
		body.canMove = false
		body.dead = true
		body.vulnerable = false
		timer  = get_node("Timer")
		timer.set_wait_time(2)
		timer.start()


func _on_Timer_timeout():
	$CanvasLayer/TextTransition/TextAnimator.play("ScreenBlockerFadeIn")


func _on_TextTransition_textFadeOut():
	GameManagerNode.loadNextLevel("res://Levels/Level 1-19.tscn", "")