extends StaticBody2D

var target
export(String, "Area", "LoS") var visionType
export(String, "vertical", "horizontal") var mirrorDirection

func _ready():
	if !mirrorDirection:
		mirrorDirection = "vertical"
	if mirrorDirection == "horizontal":
		$Sprite.texture = load("res://Art/floors_ceilings.png")
		$Sprite.hframes = 5
		$Sprite.vframes = 5
		$Sprite.frame = 24

func _physics_process(delta):
	pass

func takeDamage():
	name = "deadmirror"
	$AudioStreamPlayer2D.play(0)
	var enemies = get_tree().get_nodes_in_group("Monster")
	for enemy in enemies:
		if enemy.target == self:
			enemy.findNewTarget();
	var mirrorsLeft = get_tree().get_nodes_in_group("Mirror")
	if len(mirrorsLeft)-1 == 0:
		var exits = get_tree().get_nodes_in_group("Exit")
		for exit in exits:
			exit.revealExit();


func _on_Area2D_body_entered(body):
	if body.is_in_group("Monster"):
		if !visionType:
			visionType = "Area"
		if visionType == "Area":
			body.target = self
			playMonsterSpotted(body)
			return
		target = body
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(position, target.position, 
										[self], collision_mask)
		if result:
			if result.collider.name == "Monster":
				$Sprite.flip_v = true
				result.collider.target = self
				playMonsterSpotted(body)

func playMonsterSpotted(body):
	if mirrorDirection == "vertical":
		$AnimationPlayer.play("MonsterSpotted")
	body.sawNewTarget()


func _on_AudioStreamPlayer2D_finished():
	queue_free()


func _on_Area2D2_body_entered(body):
	pass # replace with function body
