extends Area2D

signal monster_collision


func _on_Area2D_body_entered(body):
	if body.name == "Monster":
		emit_signal("monster_collision")
