extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CreditsReturnButton_pressed():
	get_tree().change_scene("res://Levels/Main Menu.tscn")
