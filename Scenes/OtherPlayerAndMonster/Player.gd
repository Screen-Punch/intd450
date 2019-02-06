extends Area2D

# player 

export (int) var speed = 150
var screensize



func start(pos):
	position = pos
	show()


func _ready():

	screensize = get_viewport_rect().size
	

func _process(delta):
	
	var velocity = Vector2()
	

	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		

	if velocity.length()>0:

		velocity = velocity.normalized() * speed

		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity*delta


	
	if velocity.x !=0 :
		$AnimatedSprite.animation  = "Right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x<0
		
	elif velocity.y !=0 :
		$AnimatedSprite.animation  = "Up"
		$AnimatedSprite.flip_v = velocity.y>0





func _on_Button_pressed():
	show()
	$Button.hide()
