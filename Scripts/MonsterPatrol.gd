extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():

	pass



func _on_Player_body_entered(body): 
	get_tree().change_scene("res://Levels/Level1-7.tscn")


func _on_player_area_entered(area):
	get_tree().change_scene("res://Levels/Main Menu.tscn")
