extends StaticBody2D

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _on_Key_keyGotten():
	$AnimationPlayer.play("BarrierDeactivate")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "BarrierDeactivate":
		queue_free()
