extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (String, FILE, "*.tscn") var next_world

func _on_Level1_pressed():
	GameManagerNode.loadNextLevel(next_world, " ")
	GameManagerNode.set_level_selection_to_true()

