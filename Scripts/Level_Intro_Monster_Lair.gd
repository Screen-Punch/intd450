extends Node2D

var fogAdvancing = true
var counter = 0

func _ready():
	$next_W.revealExit()

func _process(delta):
	
	if counter % 1000:
		fogAdvancing = !fogAdvancing
	if fogAdvancing:
		$fog.position.x += 0.1
		$fog.position.y += 0.1
	else:
		$fog.position.x -= 0.1
		$fog.position.y -= 0.1


func _on_Key_keyGotten():
	$AnimationPlayer.play("TreasureFade")