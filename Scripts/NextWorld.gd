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
	pass


func _on_next_W_body_entered(body):
	if body.is_in_group("Player"):
		body.vulnerable = false
		$CanvasLayer/AnimationPlayer.play("SceneTransition")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "SceneTransition":
		get_tree().change_scene(next_world)
