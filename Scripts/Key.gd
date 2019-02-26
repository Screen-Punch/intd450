extends Node2D

signal keyGotten
var monster

func _ready():
	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("keyGotten")
		var enemies = get_tree().get_nodes_in_group("Monster")
		for enemy in enemies:
			enemy.findNewTarget();
		queue_free()