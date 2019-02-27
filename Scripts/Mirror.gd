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
		$Sprite.vframes = 4
		$Sprite.frame = 19

func _physics_process(delta):
	pass

func takeDamage():
	name = "deadmirror"
	var enemies = get_tree().get_nodes_in_group("Monster")
	for enemy in enemies:
		enemy.findNewTarget();
	var mirrorsLeft = get_tree().get_nodes_in_group("Mirror")
	if len(mirrorsLeft)-1 == 0:
		var blockers = get_tree().get_nodes_in_group("StairBlocker")
		for blocker in blockers:
			blocker.queue_free();
	queue_free()

func _on_Area2D_body_entered(body):
	if body.is_in_group("Monster"):
		if !visionType:
			visionType = "Area"
		if visionType == "Area":
			body.target = self
			playMonsterSpotted()
			return
		target = body
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(position, target.position, 
										[self], collision_mask)
		if result:
			if result.collider.name == "Monster":
				$Sprite.flip_v = true
				result.collider.target = self
				playMonsterSpotted()

func playMonsterSpotted():
	if mirrorDirection == "vertical":
		$AnimationPlayer.play("MonsterSpotted")
