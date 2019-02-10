extends Node2D

onready var upper_Button = $Button1
onready var right_Button = $Button2
onready var buttom_Button = $Button3
onready var left_Button = $Button4

var button_up = preload("res://Art/button_up.png")
var button_down = preload("res://Art/button_down.png")

var player
var buttons

var current_button = "UPPER"
var index_to_name = {0:"UPPER",1:"RIGHT",2:"BOTTOM",3:"LEFT",4:"NONE"}
var not_pressed = [0,1,2,3]
var pressed = []

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	buttons = [upper_Button,right_Button,buttom_Button,left_Button]
	$Label.hide()

func _process(delta):
	var button_index = check_hit()
	if button_index!= null:
		if ((index_to_name[button_index] == current_button) and (button_index in not_pressed)):
			buttons[button_index].get_node("Sprite").set_texture(button_down)
			current_button = index_to_name[button_index+1]
			not_pressed.erase(button_index)
			pressed.append(button_index)
			button_index = null
		elif ((index_to_name[button_index] != current_button) and (button_index in not_pressed)):
			for i in pressed:
				buttons[i].get_node("Sprite").set_texture(button_up)
			not_pressed = [0,1,2,3]
			pressed = []
			current_button = "UPPER"
	if not_pressed==[]:
		$Label.show()
		
	


func check_hit():
	for i in range(len(buttons)):
		var distance = buttons[i].position.distance_to(player.position)
		if distance < 55:
			return i