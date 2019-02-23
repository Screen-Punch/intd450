extends ColorRect

var value = 20
var Mat

func _ready():
	Mat = self.get_material()
	Mat.set_shader_param("blurSize", 0)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func updateBlur(value):
	Mat.set_shader_param("blurSize", value)