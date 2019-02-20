extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var button_up = preload("res://Art/button_up.png")
var button_down = preload("res://Art/button_down.png")

export (float) var timer = -1.0

signal button_pressed

	

func _on_Area2D_body_entered(body):
	if body.has_method("takeDamage"):
		$Sprite.set_texture(button_down)
		emit_signal("button_pressed")
		$CollisionShape2D.disabled = true


func _on_Node2D_reset():

	$Sprite.set_texture(button_up)
	$CollisionShape2D.disabled = false
