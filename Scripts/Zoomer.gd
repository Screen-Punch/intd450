extends Node

# zoom var 
var ifzoom = true
var zoomfactor = 1.0
var zoomspeed = 10

func _ready():
	pass

func _process(_delta):

	if Input.is_action_pressed("ui_up"):
		zoomfactor -= 0.1
	#if ifzoom:
		#zoom.x = lerp(zoom.x, zoom.x * zoomfactor, zoomspeed * delta)
		#zoom.y = lerp(zoom.y, zoom.y * zoomfactor, zoomspeed * delta)


func check():
		
	pass
