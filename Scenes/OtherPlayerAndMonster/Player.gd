extends Area2D

# player 

export (int) var speed = 150



func start(pos):
	position = pos


	

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

	
	position += velocity*delta


	





