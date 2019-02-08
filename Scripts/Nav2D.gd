extends Navigation2D

var path = []

func _ready():
	pass

func update_navigation_path(start, target):
	path = get_simple_path(start, target, true)
	path.remove(0)
	return path

func stuff():
	pass