extends Node2D

var spawned = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Area2D_body_entered(body):
	if !body.is_in_group("Player") or spawned:
		return
	spawned = true
	var monsterScene = load("res://Scenes/Monster.tscn")
	var monster = monsterScene.instance()
	get_node("/root/Level1-2/Nav2D").add_child(monster)
	monster.position = position
	monster.spawn()