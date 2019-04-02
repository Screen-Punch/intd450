extends KinematicBody2D

# This is a demo showing how KinematicBody2D
# move_and_slide works.

# Member variables
var MAX_MOTION_SPEED = 240
var MOTION_SPEED = 240 # Pixels/second
var DEATHS_PER_COLOR_CHANGE = 1
var distance = 500

var target
var vulnerable

var timer = 0
var magnitude = 10
var gap = 0.1

var canMove = false
var dead = false
var anim
var oldAnim
export (bool) var timerVisible = false
var totalMirrors = 0
var movementKey


func _ready():
	var monsters  = get_tree().get_nodes_in_group("Monster")
	for t in monsters:
		target = t
	$CanvasLayer/SceneTransition.play("SceneTransition")
	vulnerable = true
	$AnimationPlayer.play("SpawnAnimation")
	$CanvasLayer/Blur.show()
	oldAnim = ""
	anim = ""
	var deaths = GameManagerNode.totalDeaths
	updatePlayerTexture(deaths)
	if !timerVisible or GameManagerNode.level_selection_mode:
		hideTimer()
	var totalMirrors  = get_tree().get_nodes_in_group("Mirror")
	movementKey = [KEY_W, KEY_A, KEY_S, KEY_D]

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode in movementKey:
			if target and !target.spawned:
				target.spawn()
			$Camera2D/CanvasLayer/RichTextLabel.start()

func _physics_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("ui_pause"):
		$CanvasLayer/PauseMenu.show()
		get_tree().paused = true

	if canMove:
		if Input.is_action_pressed("ui_up"):
			motion += Vector2(0, -1)
		if Input.is_action_pressed("ui_down"):
			motion += Vector2(0, 1)
		if Input.is_action_pressed("ui_left"):
			motion += Vector2(-1, 0)
		if Input.is_action_pressed("ui_right"):
			motion += Vector2(1, 0)
	
		if motion.y < 0:
			anim = "WalkUp"
		elif motion.y > 0:
			anim = "WalkDown"
		if motion.x < 0:
			anim = "WalkRight"
			$sprite.flip_h = true
		elif motion.x > 0:
			anim = "WalkRight"
			$sprite.flip_h = false
		if motion == Vector2(0, 0):
			if oldAnim == "WalkUp":
				anim = "IdleUp"
			if oldAnim == "WalkDown":
				anim = "IdleDown"
			if oldAnim == "WalkRight":
				anim = "IdleRight"
		if oldAnim != anim:
			$AnimationPlayer.play(anim)
			oldAnim = anim
		
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
			if !dead:
				$Camera2D/Shaker.shake(magnitude)
			timer = 0
		var blurLevel = 0
		if vulnerable:
			blurLevel = -1*((distance)/4)+30 # Scale runs from [0,30]. Outer 30 moves value into this range.
		$CanvasLayer/Blur.updateBlur(blurLevel)

func update_magnitude_and_gap(distance):
	magnitude = pow(2,-distance/50) * 25

func takeDamage():
	if vulnerable and GameManagerNode.end_scene == false:
		vulnerable = false
		MOTION_SPEED = 0
		dead = true
		canMove = false
		$death2.play(0)
		if !GameManagerNode.playerHasDiedOnce: # First player death
			$AnimationPlayer.play("Death")
		else:
			$CanvasLayer/SceneTransition.play_backwards("SceneTransition")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "SpawnAnimation":
		canMove = true
	if anim_name == "Death":
		$CanvasLayer/TextTransition.setTransitionText(true)
		$CanvasLayer/TextTransition/TextAnimator.play("ScreenBlockerFadeIn")
		GameManagerNode.playerHasDiedOnce = true


func _on_SceneTransition_animation_finished(anim_name):
	if anim_name == "SceneTransition" and dead:
		dead = false
		MOTION_SPEED = MAX_MOTION_SPEED
		GameManagerNode.reloadLevel()

func updatePlayerTexture(deaths):
	var i = 1
	i = int((deaths+DEATHS_PER_COLOR_CHANGE)/ DEATHS_PER_COLOR_CHANGE)
	if i <= 0:	# if below limit
		i = 1
	if i > 10:	# if above limit
		i = 10
	var intVal = i
	$sprite.texture = load("res://Art/PCs" + str(intVal) + ".png")
	
func hideTimer():
	$Camera2D/CanvasLayer/RichTextLabel.hide()
	

func dimCamera():
	# Lower limit of 0.3, upper limit of 0.8
	# (0.8 - 0.3) / 4
	var delta = (0.8-0.7)/float(totalMirrors+1)
	var curLev = $CanvasModulate.color.r
	curLev -= delta
	$CanvasModulate.color = Color(curLev, curLev, curLev)

func _on_Hurtbox_body_entered(body):
	if body.is_in_group("Monster"):
		takeDamage()

func _on_TextTransition_textFadeOut():
	GameManagerNode.reloadLevel()


# used for player death animation
func updatePlayerDuringDeath():
	var i = GameManagerNode.totalDeaths
	if i <= 0:	# if below limit
		i = 1
	if i > 10:	# if above limit
		i = 10
	var intVal = i
	$sprite.texture = load("res://Art/PCs" + str(intVal) + ".png")
