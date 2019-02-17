extends Area2D

# class member variables go here, for example:
export (String, FILE, "*.tscn") var next_world
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	if !next_world:
		next_world = "res://Levels/Main Menu.tscn"


func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	var coli_list = get_overlapping_bodies()
	for coli in coli_list:
		if coli.name == "player":
			get_tree().change_scene(next_world)
	pass


