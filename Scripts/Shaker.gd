extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var camera = get_parent()


func _ready():
	pass

func shake(magnitude):
		
	var offset = Vector2()
	offset.x = rand_range(-magnitude,magnitude)
	offset.y = rand_range(-magnitude,magnitude)
	camera.set_offset(offset)
	yield(get_tree(),"idle_frame")