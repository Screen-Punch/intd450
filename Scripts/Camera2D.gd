extends Camera2D

# zoom var 
var ifzoom = true
var zoomfactor = 1.0
var zoomfactor_speed = 0.01
var zoomspeed = 20
var total_zoom = 0

func _ready():
	pass

func _process(delta):
	if ifzoom:
		zoom.x = lerp(zoom.x, zoom.x * zoomfactor, zoomspeed * delta)
		zoom.y = lerp(zoom.y, zoom.y * zoomfactor, zoomspeed * delta)
		if zoomfactor<1:
			total_zoom -= 1
		elif zoomfactor>1:
			total_zoom += 1
		zoomfactor = 1


func zoomIn(distance):
	var cri_dis = 3
	var relative_dis = distance/cri_dis+0.3
	
	if relative_dis<1:
		if -total_zoom < (1-relative_dis)*250:
			#zoom in
			zoomfactor = 1-zoomfactor_speed
		elif -total_zoom > (1-relative_dis)*250:
			#zoom out
			if total_zoom < 0:
				zoomfactor = 1+zoomfactor_speed
	else: 
		if total_zoom < 0:
			zoomfactor = 1+zoomfactor_speed

