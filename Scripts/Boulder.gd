extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var attack = 10


func start(pos):
	position = pos



func _on_Area2D_body_entered(body):
	if body.name == "Player":
		print(body.position)
		
		if body.position.y>position.y:
			var velocity = Vector2()
			velocity.y -= 10
			position += velocity
			
		if body.position.x>position.x:
			var velocity = Vector2()
			velocity.x -= 10
			position += velocity
			
		if body.position.y<position.y:
			var velocity = Vector2()
			velocity.y += 10
			position += velocity
			
		if body.position.x<position.x:
			var velocity = Vector2()
			velocity.x += 10
			position += velocity
	if body.name == "Monster":
		var vec = Vector2()
		vec.x -=20
		body.position = body.position + vec