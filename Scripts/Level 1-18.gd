extends Node2D

# class member variables go here, for example:
# var a
var color_index = -1
var move_to_monster = false
var player_walk = false
var monster_to_player = false

var player_disappear = false

var show_door = false

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
			move_to_monster = false
			timer = 0
			
			
	if player_walk:
		timer += delta
		if timer < 0.5:
			$Player.position.x += 0.4
		else:
			player_walk = false
			player_disappear = true
			$Player.position.x += 100
			timer = 0
		
		
	if player_disappear:
		$Player.hide()
		player_disappear = false
		show_door = true
		monster_to_player = true
		
	
		
	if monster_to_player:
		timer += delta
		if timer < 3:
			$Navigation2D/NavigationPolygonInstance.enabled = false
			$Navigation2D/Monster.position.x += 1
			if timer > 1.5 and show_door:
				$Door.show()
				show_door = false
				$Ending_Good.revealExit()
		else:
			monster_to_player = false
			timer = 0



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
	if body.name!= "TileMap":
		if color_index == 18:
			GameManagerNode.end_scene = true
			$Player.canMove = false
			$Player.anim = "WalkRight"
			$Player/sprite.flip_h = true
			move_to_monster = true
			$Ending.revealExit()
		else: 
			$Door.hide()
			player_walk = true
			$Player.canMove = false
			$Player.anim = "WalkRight"
		


func _on_Ending_Good_body_entered(body):
	if body.name!= "TileMap":
		monster_to_player = false
