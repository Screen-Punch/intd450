extends StaticBody2D

var RAYCASTING = false
var target

func _ready():
	pass

func _physics_process(delta):
	if RAYCASTING:
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(position, target.position, 
											[self], collision_mask)
		if result:
			if result.collider.name == "Monster":
				$Sprite.flip_v = true
				result.collider.target = self

func takeDamage():
	RAYCASTING = false
	var enemies = get_tree().get_nodes_in_group("Monster")
	for enemy in enemies:
		enemy.findNewTarget();
	queue_free()

func _on_Area2D_body_entered(body):
	if body.is_in_group("Monster"):
		RAYCASTING = true
		target = body


func _on_Area2D_body_exited(body):
	RAYCASTING = false