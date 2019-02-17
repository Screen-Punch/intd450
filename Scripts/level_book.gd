extends Node2D

onready var book = $Book
onready var S_book = $Sprite_book
var player

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	S_book.hide()
	pass

func _process(delta):
	if check_hit():
		S_book.show()
	else:
		S_book.hide()
	pass

func check_hit():
	var distance = book.position.distance_to(player.position)
	if distance < 55:
		return 1
	else:
		return 0
