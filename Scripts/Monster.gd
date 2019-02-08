extends KinematicBody2D

export (int) var SPEED = 200
var target
var velocity
onready var Nav2D = get_node("../")
var path
var timer = 0

func _ready():
	var targets = get_tree().get_nodes_in_group("Player")
	for t in targets:
		target = t
	path = Nav2D.update_navigation_path(position, target.position)

func _process(delta):
	if target:
		velocity = (target.position - position).normalized() * SPEED
		var move_dist = SPEED * delta
		move_along_path(move_dist)
#		if (target.position - position).length() > 5:
#			move_and_slide(velocity)
		timer += 1
		if timer >= 5:
			path = Nav2D.update_navigation_path(position, target.position)
			timer = 0
			
		if (target.position - position).length() < 40:
			target.takeDamage()
	else:
		findNewTarget()

func findNewTarget():
	var targets = get_tree().get_nodes_in_group("Player")
	for t in targets:
		target = t

# Used Nav2D to move
func move_along_path(distance):
	var last_point = position
	for index in range(path.size()):
		var distance_between_points = last_point.distance_to(path[0])
		# the position to move to falls between two points
		if distance <= distance_between_points and distance >= 0.0:
			position = last_point.linear_interpolate(path[0], distance / distance_between_points)
			break
		# the character reached the end of the path
		elif distance < 0.0:
			position = path[0]
			break
		distance -= distance_between_points
		last_point = path[0]
		path.remove(0)