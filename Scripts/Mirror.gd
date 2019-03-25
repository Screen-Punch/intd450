extends StaticBody2D

var target
export(String, "Area", "LoS") var visionType
export(String, "vertical", "horizontal") var mirrorDirection

func _ready():
	if !mirrorDirection:
		mirrorDirection = "vertical"
	if mirrorDirection == "horizontal":
		pass

func _physics_process(delta):
	pass

func takeDamage():
	name = "deadmirror"
	$AnimationPlayer.play("DeathAnim")
	$AudioStreamPlayer2D.play(0)
	$CollisionShape2D.queue_free()
	$Area2D.queue_free()
	self.remove_from_group("Mirror")
	var enemy = get_tree().get_nodes_in_group("Monster")[0]
	if enemy.target == self:
		enemy.findNewTarget()
	var mirrorsLeft = get_tree().get_nodes_in_group("Mirror")
	if len(mirrorsLeft) == 0:
		var exits = get_tree().get_nodes_in_group("Exit")
		for exit in exits:
			exit.revealExit();
	$Light2D.queue_free()
	var player = get_tree().get_nodes_in_group("Player")[0]
	player.dimCamera()


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
	body.sawNewTarget()


func _on_AudioStreamPlayer2D_finished():
	pass