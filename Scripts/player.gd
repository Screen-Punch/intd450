extends KinematicBody2D

# This is a demo showing how KinematicBody2D
# move_and_slide works.

# Member variables
const MOTION_SPEED = 160 # Pixels/second
var distance = 500

var target
var vulnerable

var timer = 0
var magnitude = 10
var gap = 0.1

var canMove = false
var dead = false

func _ready():
	var monsters  = get_tree().get_nodes_in_group("Monster")
	for t in monsters:
		target = t
	$CanvasLayer/SceneTransition.play("SceneTransition")
	vulnerable = true
	$AnimationPlayer.play("SpawnAnimation")
	$CanvasLayer/Blur.show()

func _input(event):
	if event is InputEventKey and !target.spawned:
		if event.pressed:
			target.spawn()

func _physics_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		motion += Vector2(0, -1)
	if Input.is_action_pressed("ui_down"):
		motion += Vector2(0, 1)
	if Input.is_action_pressed("ui_left"):
		motion += Vector2(-1, 0)
	if Input.is_action_pressed("ui_right"):
		motion += Vector2(1, 0)
	if Input.is_action_pressed("ui_pause"):
		$CanvasLayer/PauseMenu.show()
		get_tree().paused = true
	
	if canMove:
		motion = motion.normalized() * MOTION_SPEED
		move_and_slide(motion)
	
func _process(delta):
	if target:
		distance = sqrt(pow((target.position.x - position.x),2) + pow((target.position.y - position.y),2))
		timer += delta
		# zoom by distance
		$Camera2D.zoomIn(distance/100)
		if distance < 100 and timer > gap:
			update_magnitude_and_gap(distance)
			$Camera2D/Shaker.shake(magnitude)
			timer = 0
		var blurLevel = 0
		if vulnerable:
			blurLevel = -1*((distance)/4)+30 # Scale runs from [0,30]. Outer 30 moves value into this range.
		$CanvasLayer/Blur.updateBlur(blurLevel)

func update_magnitude_and_gap(distance):
	magnitude = pow(2,-distance/50) * 25

func takeDamage():
	if vulnerable:
		MOTION_SPEED = 0
		dead = true
		$CanvasLayer/SceneTransition.play_backwards("SceneTransition")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "SpawnAnimation":
		canMove = true


func _on_SceneTransition_animation_finished(anim_name):
	if anim_name == "SceneTransition" and dead:
		dead = false
		MOTION_SPEED = 150
		GameManagerNode.reloadLevel()
