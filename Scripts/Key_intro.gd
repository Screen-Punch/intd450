extends Node2D

signal keyGotten
var monster
var used = false

func _ready():
	monster = get_tree().get_nodes_in_group("Monster")[0]

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") and !used:
		used = true
		$AudioStreamPlayer2D.play(0)
		emit_signal("keyGotten")
		$Sprite.frame -= 1
