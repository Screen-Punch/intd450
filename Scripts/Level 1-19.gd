extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var which_ending
var is_walk_right = false
var timer = 0

var spawn = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$next_W.revealExit()
	which_ending = 1
	$Path2D/PathFollow2D/Player/Camera2D.zoomfactor = 1.7
	$Path2D/PathFollow2D/Player.canMove = false
	if GameManagerNode.is_first_ending:
		which_ending = 1
	elif GameManagerNode.is_second_ending:
		which_ending = 2 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	$Path2D/PathFollow2D/Player.canMove = false
	
	if spawn == false:
		timer += delta
		if timer > 2:
			spawn = true
			timer = 0
	
	elif which_ending == 1 and spawn:
		$Path2D/PathFollow2D/Player.position.x += 1
		if is_walk_right == false:
			$Path2D/PathFollow2D/Player/AnimationPlayer.play("WalkRight")
			is_walk_right = true
			