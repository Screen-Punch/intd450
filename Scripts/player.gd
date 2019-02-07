extends KinematicBody2D

# This is a demo showing how KinematicBody2D
# move_and_slide works.

# Member variables
const MOTION_SPEED = 160 # Pixels/second
var distance = 500

var target

var timer = 0
var magnitude = 10
var gap = 0.1

func _ready():
	target = get_tree().get_nodes_in_group("Monster")[0]

func _physics_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("move_up"):
		motion += Vector2(0, -1)
	if Input.is_action_pressed("move_bottom"):
		motion += Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		motion += Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		motion += Vector2(1, 0)
	
	motion = motion.normalized() * MOTION_SPEED

	move_and_slide(motion)
	
func _process(delta):
	distance = sqrt(pow((target.position.x - position.x),2) + pow((target.position.y - position.y),2))
	timer += delta
	if distance < 100 and timer > gap:
		update_magnitude_and_gap(distance)
		$Camera2D/Shaker.shake(magnitude)
		timer = 0
		
func update_magnitude_and_gap(distance):
	magnitude = pow(2,-distance/50) * 25
