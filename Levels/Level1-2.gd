extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	BGMPlayer.stream = load("res://Sounds/BGM/Halo Effect.wav")
	GameManagerNode.BGMAudioName = "res://Sounds/BGM/Halo Effect.wav"
	BGMPlayer.play(0)
