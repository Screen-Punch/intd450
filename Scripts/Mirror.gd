extends StaticBody2D

func _ready():
	pass

func takeDamage():
	var enemies = get_tree().get_nodes_in_group("Monster")
	for enemy in enemies:
		enemy.findNewTarget();
	queue_free()

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		$Sprite.flip_v = true;
		var enemies = get_tree().get_nodes_in_group("Monster")
		for enemy in enemies:
    		enemy.target = self


func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		$Sprite.flip_v = false;
#		var enemies = get_tree().get_nodes_in_group("Monster")
#		for enemy in enemies:
#			enemy.findNewTarget();