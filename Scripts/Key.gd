extends Node2D

signal keyGotten

func _ready():
	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("keyGotten")
		queue_free()