extends KinematicBody2D

export (int) var SPEED = 170
var target
var velocity
onready var Nav2D = get_node("../")
var path
var timer = 0
var randomNoiseTimer
var randomNoiseDelay
var randomMonsterNoises = ["res://Sounds/SoundFiles/24 bit/comingupto.wav", "res://Sounds/SoundFiles/24 bit/slimycrunchy.wav",
					"res://Sounds/SoundFiles/24 bit/longgroan.wav", "res://Sounds/SoundFiles/16 bit/16 bit 2/laughing.wav",
					"res://Sounds/SoundFiles/16 bit/16 bit 2/2crack.wav", "res://Sounds/SoundFiles/24 bit/3crack.wav"]
var entryNoise = "res://Sounds/SoundFiles/warp.wav"

onready var player = get_tree().get_nodes_in_group("Player")[0]
var canMove = false

func _ready():
	var targets = get_tree().get_nodes_in_group("Player")
	for t in targets:
		target = t
	path = Nav2D.update_navigation_path(position, target.position)
	$AnimationPlayer.play("SpawnAnimation")
	$AudioStreamPlayer2D.stream = load(entryNoise)
	$AudioStreamPlayer2D.play(0)
	randomNoiseTimer = get_node("Timer")
	randomNoiseTimer.set_wait_time(2)
	randomNoiseTimer.start()
	$MonsterSprites.play("MonsterMovement")

func _process(delta):
	if target:
		velocity = (target.position - position).normalized() * SPEED
		var move_dist = SPEED * delta
		if canMove:
			move_along_path(move_dist)
#		if (target.position - position).length() > 5:
#			move_and_slide(velocity)
		timer += 1
		if timer >= 5:
			path = Nav2D.update_navigation_path(position, target.position)
			timer = 0
	else:
		findNewTarget()
	var distToTarget = position.distance_to(player.position)
	$AudioStreamPlayer2D.volume_db = 20 - distToTarget/20

# Called by crystals and such when it sees a new target
func sawNewTarget():
	$SurpriseMarkAudio.play(0)
	$AnimationPlayer.play("NewTargetAnimation")

func findNewTarget():
	var otherAreas = $Area2D.get_overlapping_areas()
	var otherMirrorsInSight = []
	for i in otherAreas:
		if "Mirror" in i.get_parent().name:
			otherMirrorsInSight.append(i.get_parent())
	if len(otherMirrorsInSight) > 0:
		var closestMirrorDist = 999999
		var closestMirror = otherMirrorsInSight[0]
		for mirror in otherMirrorsInSight:
			var dist = mirror.position.distance_to(global_position)
			if dist < closestMirrorDist:
				closestMirrorDist = dist
				closestMirror = mirror
		target = closestMirror
		sawNewTarget()
		return
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

func _on_Area2D_body_entered(body):
	if body.has_method("takeDamage"):
		body.takeDamage()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "SpawnAnimation":
		canMove = true


func change_speed(new_speed):
	SPEED = new_speed

func _on_Timer_timeout():
	var index = randi() % len(randomMonsterNoises)
	$AudioStreamPlayer2D.stream = load(randomMonsterNoises[index])
	$AudioStreamPlayer2D.play(0)
	randomNoiseDelay = randi() % 5 + 10
	randomNoiseTimer.set_wait_time(randomNoiseDelay)
	randomNoiseTimer.start()
