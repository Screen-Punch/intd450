extends RichTextLabel

var ms = 0
var s = -1
var started = false

func _process(delta):
	if started:
		if ms>9:
			s += 1
			ms = 0
		set_text(str(s)+":"+str(ms))

func _on_Timer_timeout():
	ms += 1
	GameManagerNode.set_current_time(get_time())
	pass # replace with function body
	
func get_time():
	return s+0.1*ms

func start():
	started = true