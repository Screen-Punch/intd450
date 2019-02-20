extends Node2D

# class member variables go here, for example:
# var a = 2

var correct_order = ["UP","RIGHT","BOTTOM","LEFT"]
var current_order = []

signal reset

var timing = false


func _process(delta):
	if current_order.size() == 4 and timing == false:
		if current_order==correct_order:
			$Label.show()
		else:
			$Timer.start()
			timing = true
			
		


func _on_ButtonUp_button_pressed():
	current_order.append("UP")


func _on_ButtonRight_button_pressed():
	current_order.append("RIGHT")


func _on_ButtonBottom_button_pressed():
	current_order.append("BOTTOM")


func _on_ButtonLeft_button_pressed():
	current_order.append("LEFT")


func _on_Timer_timeout():
	timing = false
	emit_signal("reset")
	current_order = []
	$Timer.stop()
	$Timer.set_wait_time(1)
