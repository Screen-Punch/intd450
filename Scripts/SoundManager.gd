extends AudioStreamPlayer
func _Protag_Sound(sfx, position):
	
	#sound location calculated relative to protagonist, redirected to main sound
	#function used by other scripts involving diagetic sounds (switches, enemies, etc)
	#volume determined by distance between source and PC
	#Panning determined by direction.
	#Volume reduction linear with Db
	#as this is primarily for SFX, wav files are recommended.
	
	
	
func _BGM_Sound(sound):
	pass