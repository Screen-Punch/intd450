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
var delayTimer

var BAD_END_DEATH_THRESHOLD = 18

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if move_to_monster:
		timer += delta
		if timer < 6:
			$Player.position.x -= 1
		else:
			move_to_monster = false
			timer = 0
			
			
	if player_walk:
		timer += delta
		if timer < 2:
			$Player.position.x += 1
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



func _on_Ending_Good_body_entered(body):
	if body.name!= "TileMap":
		monster_to_player = false


func _on_Ending_Decide_body_entered(body):
	if body.is_in_group("Player") and GameManagerNode.totalDeaths >= BAD_END_DEATH_THRESHOLD:
		$Door/Sprite.modulate = Color(1, 0, 0)


func _on_Area2D_body_entered(body):	# door touched
	if body.is_in_group("Player") or body.is_in_group("Monster"):
		if GameManagerNode.totalDeaths >= BAD_END_DEATH_THRESHOLD: #bad ending
			GameManagerNode.end_scene = true
			$Player.canMove = false
			$Player.anim = "WalkRight"
			$Player/sprite.flip_h = true
			move_to_monster = true
			$Ending.revealExit()
		else:
			if body.is_in_group("Player"):
				$Door.hide()
				player_walk = true
				$Player.canMove = false
				$Player.anim = "WalkRight"
				$Navigation2D/Monster.cutscene = true
				$Navigation2D/Monster.SPEED = 50
				$Door/Sprite.modulate = Color(1, 0, 0)

func _on_Timer_timeout():
	$Navigation2D/Monster.SPEED = 50

func _on_PauseArea_body_entered(body):
	delayTimer = get_node("Timer")
	delayTimer.set_wait_time(1)
	delayTimer.start()
	$Navigation2D/Monster.SPEED = 0