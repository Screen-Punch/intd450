extends Area2D

# class member variables go here, for example:
export (String, FILE, "*.tscn") var next_world
export (String) var transitionText
var blocked = true

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	if !next_world:
		next_world = "res://Levels/Main Menu.tscn"
	if !transitionText:
		transitionText = "What is that sound..?"
	$CanvasLayer/Label.text = transitionText


func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass


func _on_next_W_body_entered(body):
	if body.is_in_group("Player") and !blocked:
		body.vulnerable = false
		$CanvasLayer/AnimationPlayer.play("SceneTransition")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "SceneTransition":
		GameManager.loadNextLevel(next_world)

func revealExit():
	blocked = false
	$CanvasLayer/AnimationPlayer.play("ExitUnlocked")
