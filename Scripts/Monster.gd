extends KinematicBody2D

export (int) var SPEED = 50
var target
var velocity

func _ready():
	var targets = get_tree().get_nodes_in_group("Player")
	for t in targets:
		target = t

func _process(delta):
	if target:
		velocity = (target.position - position).normalized() * SPEED
		if (target.position - position).length() > 5:
			move_and_slide(velocity)

func findNewTarget():
	var targets = get_tree().get_nodes_in_group("Player")
	for t in targets:
		target = t	