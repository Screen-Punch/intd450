extends Button
export (String, FILE, "*.tscn") var next_world


func _on_LevelSelection_pressed():
	GameManagerNode.loadNextLevel(next_world, " ")
	GameManagerNode.set_level_selection_to_true()

