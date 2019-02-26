extends Node

var played = false

func _ready():
	$Label.modulate.a = 0.0


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") and !played:
		played = true
		$AnimationPlayer.play("DisplayText")
