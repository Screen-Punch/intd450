extends KinematicBody2D

# Declare member variables here. Examples:
var vulnerable = true
var DEATHS_PER_COLOR_CHANGE = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var deaths = GameManagerNode.totalDeaths
	updatePlayerTexture(deaths)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func hideTimer():
	$Camera2D/CanvasLayer/RichTextLabel.hide()
	
func updatePlayerTexture(deaths):
	var i = 1
	i = int((deaths+DEATHS_PER_COLOR_CHANGE)/ DEATHS_PER_COLOR_CHANGE)
	if i <= 0:	# if below limit
		i = 1
	if i > 10:	# if above limit
		i = 10
	var intVal = i
	$sprite.texture = load("res://Art/PCs" + str(intVal) + ".png")