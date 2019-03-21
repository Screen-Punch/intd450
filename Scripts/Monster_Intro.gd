extends KinematicBody2D

var MAXSPEED
export (int) var SPEED = 170
var target
var velocity
onready var Nav2D = get_node("../")
var path
var pos
var timer = 0
var randomNoiseTimer
var randomNoiseDelay
var randomMonsterNoises = ["res://Sounds/SoundFiles/24 bit/comingupto.wav", "res://Sounds/SoundFiles/24 bit/slimycrunchy.wav",
					"res://Sounds/SoundFiles/24 bit/longgroan.wav", "res://Sounds/SoundFiles/16 bit/16 bit 2/laughing.wav",
					"res://Sounds/SoundFiles/16 bit/16 bit 2/2crack.wav", "res://Sounds/SoundFiles/24 bit/3crack.wav"]
var entryNoise = "res://Sounds/SoundFiles/warp.wav"
var spawned = false

var start_move = false

signal can_move


const CHASING_PLAYER_COLOR = Color(1, 1, 1, 1)
const CHASING_MIRROR_COLOR = Color(0.1, 1, 0.1, 1)

func start(pos):
	position = pos


func _ready():
	MAXSPEED = SPEED
	$Sprite.self_modulate = CHASING_PLAYER_COLOR
	

func spawn():
	spawned = true
	$AnimationPlayer.play("SpawnAnimation")
	$AudioStreamPlayer2D.stream = load(entryNoise)
	$AudioStreamPlayer2D.play(0)
	randomNoiseTimer = get_node("Timer")
	randomNoiseTimer.set_wait_time(2)
	randomNoiseTimer.start()
	$MonsterSprites.play("MonsterMovement")

func _process(delta):

	if start_move:
		timer += delta
		if timer < 6.45:
			var motion = Vector2()
			motion.x +=1
			position += motion
		if timer > 6.45 and timer < 7.8:
			var motion = Vector2()
			motion.y +=1
			position += motion
		if timer > 7.8:
			hide()
			emit_signal("can_move")
	$Sprite.rotation += 0.01
	


func _on_Timer_timeout():
	var index = randi() % len(randomMonsterNoises)
	$AudioStreamPlayer2D.stream = load(randomMonsterNoises[index])
	$AudioStreamPlayer2D.play(0)
	randomNoiseDelay = randi() % 5 + 10
	randomNoiseTimer.set_wait_time(randomNoiseDelay)
	randomNoiseTimer.start()
