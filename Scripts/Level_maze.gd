extends Node2D

var timer = 0.0
var timer_start = false
var speed = -2


func _process(delta):
	if timer > 0.0 and timer_start:
		if int(timer*3)%2 == 1:
			speed = -2
		else:
			speed = 2
		timer-=delta
		var vec = Vector2()
		vec.x += speed
		$Nav2D/Monster.position += vec
	elif timer_start:
		speedup()
		timer_start = false
		$Barrier.hide()
	

func _on_Button_button_pressed():
	$Barrier.show()


func _on_Barrier_monster_collision():
	if timer_start==false:
		$Nav2D/Monster.change_speed(0)
		timer_start = true
		timer = 10.0


func speedup():
	$Nav2D/Monster.change_speed(170)