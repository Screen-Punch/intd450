extends Node2D

# class member variables go here, for example:
# var a
var color_index = -1
var move_to_monster = false

var timer = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if move_to_monster:
		timer += delta
		if timer < 3:
			$Player.position.x -= 1
		else:
			move_to_monster = true



func _on_Ending_Decide_area_entered(area):
	var color_indicator = ""
	var sprite = $Player/sprite.texture.resource_path
	var path = str(sprite)
	for i in path:
		if int(i) or str(i) == "0":
			color_indicator += str(i)
	color_indicator = int(color_indicator)
	color_index = color_indicator
	if color_indicator == 18:
		$Door/Sprite.modulate = Color(1, 0, 0)


func _on_Door_body_entered(body):
	if color_index > 2:
		print(color_index)
		GameManagerNode.end_scene = true
		$Player.canMove = false
		$Player.anim = "WalkRight"
		$Player/sprite.flip_h = true
		move_to_monster = true
		$Ending.revealExit()
