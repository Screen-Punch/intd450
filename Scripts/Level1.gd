extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (String, FILE, "*.tscn") var next_world

func _ready():
	var level
	if "Level" in name:
		level = name.split("Level")[1]
		level = int(level)
		if GameManagerNode.level_time[level] != -1:
			$LockSprite.hide()
			disabled = false
		connect("mouse_entered", get_parent(), "_on_Level_mouse_entered", [level])

func _on_Level1_pressed():
	$click.play(0)
	BGMPlayer.stream = load("res://Sounds/BGM/Outonalimb.wav")
	BGMPlayer.play(0)
	GameManagerNode.BGMAudioName = "res://Sounds/BGM/Outonalimb.wav"
	GameManagerNode.loadNextLevel(next_world, " ")
	GameManagerNode.set_level_selection_to_true()


# testing (wang)
var testing = 0
func _process(delta):
	if testing:
		if Input.is_action_pressed("ui_up"):
			GameManagerNode.loadNextLevel("res://Levels/Level1-8.tscn","")