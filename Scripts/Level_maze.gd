extends Node2D

var timer = 0.0
var timer_start = false

func _process(delta):
	if timer > 0.0 and timer_start:
		timer-=delta
	elif timer_start:
		speedup()
		timer_start = false
		$Barrier.hide()
	

func _on_Button_button_pressed():
	$Barrier.show()


func _on_Barrier_monster_collision():
	$Nav2D/Monster.change_speed(0)
	timer_start = true
	timer = 3.0
	
func speedup():
	$Nav2D/Monster.change_speed(170)