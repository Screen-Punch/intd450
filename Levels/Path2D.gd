extends Path2D


onready var PathFollow2D = get_node("PathFollow2D")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_tree().get_root().get_node("Level 1-19").which_ending == 2:
		PathFollow2D.set_offset(PathFollow2D.get_offset()+70*delta)
