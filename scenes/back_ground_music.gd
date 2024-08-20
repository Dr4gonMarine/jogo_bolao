extends AudioStreamPlayer

@export var songs : Array[AudioStream] = []
var started_once := false

func _start_music() -> void:
	if(!started_once):
		stream = songs[1]
		started_once = true
		play()
