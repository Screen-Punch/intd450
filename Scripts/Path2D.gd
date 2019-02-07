extends Path2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var PathFollow2D = get_node("Monster1")
onready var PathFollow2D2 = get_node("Monster2")
onready var PathFollow2D3 = get_node("Monster3")
onready var PathFollow2D4 = get_node("Monster4")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
	PathFollow2D.set_offset(PathFollow2D.get_offset()+70*delta)
	PathFollow2D2.set_offset(PathFollow2D2.get_offset()+50*delta)
	PathFollow2D3.set_offset(PathFollow2D3.get_offset()+100*delta)
	PathFollow2D4.set_offset(PathFollow2D4.get_offset()+70*delta)

