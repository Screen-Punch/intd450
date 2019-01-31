extends KinematicBody2D

export (int) var SPEED = 200
var target
var velocity

func _ready():
	target = get_tree().get_nodes_in_group("Player")[0]

func _process(delta):
	if target:
		velocity = (target.position - position).normalized() * SPEED
		if (target.position - position).length() > 5:
			move_and_slide(velocity)
