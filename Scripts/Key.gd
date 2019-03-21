extends Node2D

signal keyGotten
var monster
var used = false

func _ready():
	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") and !used:
		used = true
		$AudioStreamPlayer2D.play(0)
		emit_signal("keyGotten")
		var enemies = get_tree().get_nodes_in_group("Monster")
		for enemy in enemies:
			enemy.findNewTarget();
		$Sprite.frame = 1