extends Node2D

# class member variables go here, for example:
# var a

var timer

func _ready():
	if GameManagerNode.totalDeaths >= GameManagerNode.BAD_END_DEATH_THRESHOLD:
		$CanvasLayer/Label.text = "The desire now lingering in your heart…embrace it. Submit to it. Comprehension will come in due time. Steel yourself, now. The surface world rushes to greet you once again..."
	else:
		$CanvasLayer/Label.text = "You may have found your escape, mortal, but delude yourself not: you have been changed in ways that you will carry upon your shoulders for the rest of your days. You, or another, will return in due time… it is inevitable. And I shall be waiting."

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
	$CanvasLayer/AnimationPlayer.play("Ending")


func _on_AnimationPlayer_animation_finished(anim_name):
	GameManagerNode.loadNextLevel("res://Levels/Level 1-19.tscn", "")