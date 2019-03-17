extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var timer = 0
var changed = false


func _process(delta):
	timer += delta
	if timer < 1.0:
		$Player.position.x -=1
	else:
		if changed == false:
			$Player.control = true
			$Player.canMove = true
			changed = true
	
	#var v = Vector2()
	$fog.position.x += 0.1
	$fog.position.y += 0.1


func _on_Button_button_pressed():
	$Monster.show()
	$Monster.start_move = true
	$Door.show()
	$black.hide()
	$next_W.show()
	$next_W.revealExit()
