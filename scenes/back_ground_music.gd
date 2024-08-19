extends AudioStreamPlayer

func _start_music() -> void:
	if(!playing):
		play()
